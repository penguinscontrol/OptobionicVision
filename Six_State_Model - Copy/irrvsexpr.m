close all; clear
diam=30;
drawD=1;
cell=@(x,y) rectangle('Curvature',[1,1],'Position',[x y diam*drawD diam*drawD]);

gridmin=-1000;
gridmax=1000;
N_pixel=67; %pixels per row %67 %input('Number of Cells per row?');
N_cell=30; %total number of cells

%%Create a grid of the pixels
%Erinn was here
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
pos=linspace(gridmin,gridmax-diam,N_pixel);
for k=1:N_pixel
    for l=1:N_pixel
        somas(k,l)=cell(pos(k),pos(l));
        posC(k+N_pixel*(l-1),:)=[pos(k),pos(l)];
    end
end
N_cell=N_pixel^2;

%%This creates uniform randomly spaced cells
% posC=randi([gridmin gridmax-diam],N_cell,2);
% for n=1:N_cell
%     somas(n)=cell(posC(n,1),posC(n,2));
%     if N_cell<50
%         axons(n)=line([posC(n,1)+diam gridmax],[posC(n,2) posC(n,2)],'Color',[.9 .1 .9]);
%     end
% end

axis([gridmin gridmax gridmin gridmax])

%%Create stimulation irradiance values

% sample=randi([1 100],10,1);
% set(h(sample),'FaceColor',[.5 .9 .9])
% 
% irrad=zeros(size(h,1)*size(h,2),1);
% irrad(sample)=.05;

value=linspace(.05,40,N_pixel);
exprvalue = linspace(1e-5,1e0,N_pixel);%ones(1,N_pixel^2).*36e-4;
[irradiances, expressions] = meshgrid(value,exprvalue);

%exprvalue = linspace(1e-4, 1e-2, N_pixel^2);
for n=1:(N_pixel^2)
    set(h(n),'FaceColor',[n/(N_pixel^2) 1 1]);
    irrad(n)=irradiances(n);
    %text(posC(n,1)-100,posC(n,2)+100,sprintf('%f',exprvalue(n)));
    expr(n) = expressions(n);
end
set(gca,'XTickLabel',sprintf('%f|',value));
set(gca,'YTick',posP,'XTick',posP);
set(gca,'YTickLabel',sprintf('%f|',exprvalue));
 pause(5e-4);
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
    nseg = ceil(axonL/50);
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
         if (find(retina(n).cells.vsoma(15:end)>0))
             if (length(find(retina(n).cells.vsoma(15:end)>0))>75)
                set(somas(n),'FaceColor','g')
             else
                set(somas(n),'FaceColor','r')
             end
            %good=irrad(n);
         else
            set(somas(n),'FaceColor',[.9 .9 .5])
            % fails=fails+1;
            % bad=irrad(n);
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