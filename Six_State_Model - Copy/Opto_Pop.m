close all; clear

cell=@(x,y) rectangle('Curvature',[1,1],'Position',[x y 30 30]);

N_cell=15; %67 %input('Number of Cells per row?');

%%Create a grid of the pixels
figure; hold on
posP=linspace(-1000,1000,N_cell+1);
for k=1:N_cell
    for l=1:N_cell
        w=mean(diff(posP));
        h(k,l)=rectangle('Position',[posP(k) posP(l) w,w],'EdgeColor','b');
    end
end

posC = randi([-1000 1000-30],N_cell,2);
%%This create a equally spaced 
pos=linspace(-1000,1000-30,N_cell);
for k=1:N_cell
    for l=1:N_cell
        somas(k,l)=cell(pos(k),pos(l));
    end
end

axis([-1000 1000 -1000 1000])

%%Create stimulation irradiance values

% sample=randi([1 100],10,1);
% set(h(sample),'FaceColor',[.5 .9 .9])
% 
% irrad=zeros(size(h,1)*size(h,2),1);
% irrad(sample)=.05;

value=linspace(.01,10,N_cell^2);
for n=1:(N_cell^2)
    set(h(n),'FaceColor',[n/(N_cell^2) 1 1])
    irrad(n)=value(n);
end
%%Send the information to neuron
retina=struct();
fails=0;
good=0
nseg = 20;
for n=1:length(irrad)
    if (irrad(n)~=0) 
        %sprintf('Here')
        neuronfile=['C:\nrn73\bin\nrniv.exe -nobanner -c "x=' sprintf('%f',irrad(n)) '" validate2.hoc -c quit()'] %localcellopto.hoc -c quit()'];
        dos(neuronfile);
        retina(n).cells=importNeuron();
        if (find(retina(n).cells.vaxon(10:end)>0))
            set(somas(n),'FaceColor',[.9 .5 .9])
            good=irrad(n);
        else
           set(somas(n),'FaceColor',[.9 .9 .5])
           % fails=fails+1
          %  bad=irrad(n);
        end
        if fails>3
            break
        end
     else
%         sprintf('Not Here')
         retina(n).cells=[];
    end
end




