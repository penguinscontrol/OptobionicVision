close all; clear
diam=10;
drawD=24;
cell=@(x,y) rectangle('Curvature',[1,1],'Position',[x y diam*drawD diam*drawD]);

gridmin=-12e3;
gridmax=12e3;
%N_pixel=5; %pixels per row %67 %input('Number of Cells per row?');
N_pixel=100; %total number of cells

%% Create a grid of the pixels
figure; hold on
value=linspace(.01,3.5,N_pixel);
exprvalue = linspace(5e-6,2e-2,N_pixel);%ones(1,N_pixel^2).*36e-4;
[irrad, expr] = meshgrid(value,exprvalue);

N_pixel=length(irrad);

%figure();
%% Generate the grid
posP=linspace(gridmin,gridmax,N_pixel+1);
[gridx,gridy] = meshgrid(posP(1:(end-1)),flipud(posP(1:(end-1))));
gridy = flipud(gridy);
normIrr=max(max(irrad));
w=mean(diff(posP));
%exprvalue = linspace(1e-2,1e-2,N_pixel^2);

chr2locats =@(nseg) [1:nseg]./nseg-1./(2.*nseg);
cellcheck=zeros(N_pixel,N_pixel);

%% One cell per pixel
 for k=1:N_pixel.^2
        h(k)=rectangle('Position',[gridx(k) gridy(k) w,w],'EdgeColor','b');
        somas(k)=cell(gridx(k)+w./2,gridy(k)+w/2);
        posC(k,1)=gridx(k)+w./2;
        posC(k,2)=gridy(k)+w./2;
        
        set(h(k),'FaceColor',irrad(k)/normIrr*[1 1 1]);
        axonL=w-diam/2-90;
        nseg = 1.6e3/50; %ceil(axonL/500);
        irrmags=irrad(k)*[1 1 [1 1], ones(1, nseg)];
        exprlevs=expr(k)*[1 1 [1 1], ones(1,nseg)];
        chr2locs=[.5 .5 chr2locats(2) chr2locats(nseg)];
        tot_nseg = length(irrmags);
        
        dlmwrite('matlab_irrmag_out',irrmags,' ');
        dlmwrite('matlab_chr2locs_out',chr2locs,' ');
        dlmwrite('matlab_expr_out',exprlevs,' ');
        nrncommand = ['C:\nrn73w64\bin64\nrniv.exe -nobanner -c "mat_nseg='...
            sprintf('%f',tot_nseg) '" locals_pop.hoc -c quit()'];
        dos(nrncommand);
        fprintf('Irradiance was %f \n', irrmags(1));
        fprintf('Expression was %f',exprlevs(1));
        cells=importNeuron();
         if (find(cells.vsoma(15:end)>0))
             if (length(find(cells.vsoma(15:end)>0))>75)
                set(somas(k),'FaceColor','g')
                cellcheck(k)=2;
             else
                set(somas(k),'FaceColor','r')
                cellcheck(k)=1;
             end
         else
            set(somas(k),'FaceColor',[.9 .9 .5])
                cellcheck(k)=0;
         end 
           irrmags = [];
    chr2locs = []; 
 end

axis([gridmin gridmax gridmin gridmax]);
%axis([0 N_pixel 0 N_pixel]);
set(gca,'XTick',posP+w/2);
set(gca,'XTickLabel',value);
set(gca,'YTick',posP+w/2);
set(gca,'YTickLabel',exprvalue);
xlabel('Irradiances');
ylabel('Expression Levels');

