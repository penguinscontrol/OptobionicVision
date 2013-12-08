close all; clear
diam=30;
cell=@(x,y) rectangle('Curvature',[1,1],'Position',[x y diam diam]);

gridmin=-1000;
gridmax=1000;
N_pixel=5; %pixels per row %67 %input('Number of Cells per row?');
N_cell=10; %total number of cells

%%Create a grid of the pixels
figure; hold on
posP=linspace(gridmin,gridmax,N_pixel+1);
whp=0;
for k=1:N_pixel
    for l=1:N_pixel
        w=mean(diff(posP));
        h(k,l)=rectangle('Position',[posP(k) posP(l) w,w],'EdgeColor','b');
        whp=whp+1;
        b(k,l)=whp;
    end
end

% %%This create a equally spaced cells
% pos=linspace(gridmin,gridmax-diam,N_pixel);
% for k=1:N_pixel
%     for l=1:N_pixel
%         somas(k,l)=cell(pos(k),pos(l));
%     end
% end

%%This creates uniform randomly spaced cells
posC=randi([gridmin gridmax-diam],N_cell,2);
for n=1:N_cell
    somas(n)=cell(posC(n,1),posC(n,2));
    if N_cell<50
        axons(n)=line([posC(n,1)+diam gridmax],[posC(n,2) posC(n,2)],'Color',[.9 .1 .9]);
    end
end

axis([gridmin gridmax gridmin gridmax])

%%Create stimulation irradiance values

% sample=randi([1 100],10,1);
% set(h(sample),'FaceColor',[.5 .9 .9])
% 
% irrad=zeros(size(h,1)*size(h,2),1);
% irrad(sample)=.05;

value=linspace(.1,10,N_pixel^2);
exprvalue = linspace(1e-4, 1e-2, N_pixel^2);
for n=1:(N_pixel^2)
    set(h(n),'FaceColor',[n/(N_pixel^2) 1 1])
    irrad(n)=value(n);
    expr(n) = exprvalue(n);
end
 
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
    nseg = floor(axonL/50);
    [irrmags, exprlevs, chr2locs]=findirrad(axonL,nseg,[posC(n,1)+90+diam,posC(n,2)],irrad,expr,posP,N_pixel);
    
    irrmags = [irrSoma irrIN irrThin irrmags];
    chr2locs = [locSoma locIN locThin chr2locs];
    exprlevs = [exprSoma exprIN exprThin exprlevs];
    tot_nseg = length(irrmags);
    
    dlmwrite('matlab_irrmag_out',irrmags,' ');
    dlmwrite('matlab_chr2locs_out',chr2locs,' ');
    dlmwrite('matlab_expr_out',exprlevs,' ');
    nrncommand = ['C:\nrn73\bin\nrniv.exe -nobanner -c "mat_nseg='...
        sprintf('%f',tot_nseg)...
        '" locals_pop.hoc -c quit()'];
    dos(nrncommand);
    retina(n).cells=importNeuron();
         if (find(retina(n).cells.vsoma(10:end)>0))
             set(somas(n),'FaceColor',[.9 .5 .9])
             good=irrad(n);
         else
            set(somas(n),'FaceColor',[.9 .9 .5])
             fails=fails+1;
             bad=irrad(n);
         end    
end

figure;
numplots = ceil(sqrt(N_cell));
for a = 1:length(retina)
    subplot(numplots,numplots,a);
    plot(retina(a).cells.vaxon);
end
% %%Send the information to neuron
% retina=struct();
% fails=0;
% good=0
% for n=1:length(irrad)
%     if (irrad(n)~=0) 
%         %sprintf('Here')
%         neuronfile=['C:\nrn73w64\bin64\nrniv.exe -nobanner -c "x=' sprintf('%f',irrad(n)) '" validate.hoc -c quit()'] %localcellopto.hoc -c quit()'];
%         dos(neuronfile);
%         retina(n).cells=importNeuron();
%         if (find(retina(n).cells.vsoma(10:end)>0))
%             set(somas(n),'FaceColor',[.9 .5 .9])
%             good=irrad(n);
%         else
%            set(somas(n),'FaceColor',[.9 .9 .5])
%            % fails=fails+1
%           %  bad=irrad(n);
%         end
%         if fails>3
%             break
%         end
%      else
% %         sprintf('Not Here')
%          retina(n).cells=[];
%     end
% end