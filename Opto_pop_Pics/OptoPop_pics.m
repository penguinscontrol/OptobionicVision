close all; clear
diam=30;
drawD=4;
cell=@(x,y) rectangle('Curvature',[1,1],'Position',[x y diam*drawD diam*drawD]);

gridmin=-12e3;
gridmax=12e3;
%N_pixel=5; %pixels per row %67 %input('Number of Cells per row?');
N_cell=100; %total number of cells

%% Create a grid of the pixels
figure; hold on
irrad=ImageProcess('DukeLogo.jpg',15);
N_pixel=length(irrad);


%% Generate the grid
posP=linspace(gridmin,gridmax,N_pixel);
[gridx,gridy] = meshgrid(posP,posP);
[addrx,addry] = meshgrid([1:N_pixel]);

normIrr=max(max(irrad));

w=mean(diff(posP));
 for k=1:N_pixel.^2
         h(addrx(k),addry(k))=rectangle('Position',[gridx(k) gridy(k) w,w],'EdgeColor','b');
        somas(addrx(k),addry(k))=cell(gridx(k)+w./2,gridy(k)+w/2);
        posC(k,1)=gridx(k);
        posC(k,2)=gridy(k);
        
        set(h(addrx(k),addry(k)),'FaceColor',irrad(k)/normIrr*[1 1 1]);
 end
N_cell=N_pixel^2;
exprvalue = linspace(1e-1,1e-1,N_pixel^2);

axis([gridmin gridmax gridmin gridmax])
% %%This creates uniform randomly spaced cells
% posC=randi([gridmin gridmax-diam],N_cell,2);
% for n=1:N_cell
%     somas(n)=cell(posC(n,1),posC(n,2));
%     if N_cell<50
%         axons(n)=line([posC(n,1)+diam gridmax],[posC(n,2) posC(n,2)],'Color',[.9 .1 .9]);
%     end
% end
% pause(1e-4)

%%Create stimulation irradiance values

% sample=randi([1 100],10,1);
% set(h(sample),'FaceColor',[.5 .9 .9])
% 
% irrad=zeros(size(h,1)*size(h,2),1);
% irrad(sample)=.05;

% value=linspace(50,50,N_pixel^2);
%ones(1,N_pixel^2).*36e-4;
%exprvalue = linspace(1e-4, 1e-2, N_pixel^2);
%for n=1:(N_pixel^2)
%     irrad(n)=value(n);
%     text(posC(n,1)-100,posC(n,2)+100,sprintf('%f',exprvalue(n)));
%end
%  pause(5e-4);
%%Send the information to neuron
retina=struct();

for n=1:N_cell
    %soma
    [irrSoma, exprSoma, locSoma]=findirrad(diam,1,posC(n,:),irrad,expr,posP,N_pixel);
    %inital segment
    [irrIN, exprIN, locIN]=findirrad(diam,1,[posC(n,1)+diam,posC(n,2)],irrad,expr,posP,N_pixel);
    %Thin Segment
    [irrThin, exprThin, locThin]=findirrad(60,2,[posC(n,1)+diam+30,posC(n,2)],irrad,expr,posP,N_pixel);
    %Axon Segment
    axonL=gridmax-diam-90-posC(n,1);
    nseg = ceil(axonL/500);
    if axonL > 0
        [irrmags, exprlevs, chr2locs]=findirrad(axonL,nseg,[posC(n,1)+90+diam,posC(n,2)],irrad,expr,posP,N_pixel);
    else
        irrmags = 0;
        exprlevs = 0;
        chr2locs = 0.5;
        nseg = 1;
    end
    
    
    irrmags = [irrSoma irrIN irrThin irrmags];
    chr2locs = [locSoma locIN locThin chr2locs];
    exprlevs = [exprvalue(n) zeros(1,length(exprIN)) zeros(1,length(exprThin)) zeros(1,length(exprlevs))];
    tot_nseg = length(irrmags);
    
    dlmwrite('matlab_irrmag_out',irrmags,' ');
    dlmwrite('matlab_chr2locs_out',chr2locs,' ');
    dlmwrite('matlab_expr_out',exprlevs,' ');
    nrncommand = ['C:\nrn73\bin\nrniv.exe -nobanner -c "mat_nseg='...
        sprintf('%f',tot_nseg)...
        '" locals_pop.hoc -c quit()'];
    dos(nrncommand);
    fprintf('Expression was %f',exprlevs(1));
    retina(n).cells=importNeuron();
         if (find(retina(n).cells.vsoma(10:end)>0))
             set(somas(n),'FaceColor','r')
         else
            set(somas(n),'FaceColor',[.9 .9 .5])
         end
    retina(n).expr = exprSoma;
end

figure;
numplots = ceil(sqrt(N_cell));
for a = 1:length(retina)
    subplot(numplots,numplots,a);
    plot(retina(a).cells.vsoma);
    title(sprintf('%f',retina(a).expr));
end
