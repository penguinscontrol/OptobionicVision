close all; clear
diam=30;
drawD=4;
cell=@(x,y) rectangle('Curvature',[1,1],'Position',[x y diam*drawD diam*drawD]);

gridmin=-12e3;
gridmax=12e3;
%N_pixel=5; %pixels per row %67 %input('Number of Cells per row?');
N_pixel=3; %total number of cells

%% Create a grid of the pixels
figure; hold on
value=linspace(.05,25,N_pixel);
exprvalue = linspace(1e-5,2e-2,N_pixel);%ones(1,N_pixel^2).*36e-4;
[irrad, expr] = meshgrid(value,exprvalue);

N_pixel=length(irrad);

figure();
%% Generate the grid
posP=linspace(gridmin,gridmax,N_pixel+1);
[gridx,gridy] = meshgrid(posP(1:(end-1)),flipud(posP(1:(end-1))));
gridy = flipud(gridy);
normIrr=max(max(irrad));
w=mean(diff(posP));
exprvalue = linspace(1e-2,1e-2,N_pixel^2);
%% One cell per pixel
 for k=1:N_pixel.^2
        h(k)=rectangle('Position',[gridx(k) gridy(k) w,w],'EdgeColor','b');
        somas(k)=cell(gridx(k)+w./2,gridy(k)+w/2);
        posC(k,1)=gridx(k)+w./2;
        posC(k,2)=gridy(k)+w./2;
        
        set(h(k),'FaceColor',irrad(k)/normIrr*[1 1 1]);
 end
N_cell=N_pixel^2;

axis([gridmin gridmax gridmin gridmax]);

for n=1:N_cell
    %soma
    [irrSoma, exprSoma,locSoma]=findirrad(diam,1,posC(n,:),irrad,exprvalue,posP,N_pixel);
    %inital segment
    [irrIN, exprIN,locIN]=findirrad(diam,1,[posC(n,1)+diam,posC(n,2)],irrad,exprvalue,posP,N_pixel);
    %Thin Segment
    [irrThin,exprThin,locThin]=findirrad(60,2,[posC(n,1)+diam+30,posC(n,2)],irrad,exprvalue,posP,N_pixel);
    %Axon Segment
    axonL=gridmax-diam-90-posC(n,1);
    nseg = ceil(axonL/500);
    if axonL > 0
        [irrmags, chr2locs]=findirrad(axonL,nseg,[posC(n,1)+90+diam,posC(n,2)],irrad,exprvalue,posP,N_pixel);
    else
        irrmags = 0;
        chr2locs = 0.5;
        nseg = 1;
    end
    
    irrmags = [irrSoma irrIN irrThin irrmags];
    chr2locs = [locSoma locIN locThin chr2locs];
    exprlevs = [exprvalue(n) zeros(1,length(irrIN)) zeros(1,length(irrThin)) zeros(1,length(irrmags))];
    tot_nseg = length(irrmags);
    
    dlmwrite('matlab_irrmag_out',irrmags,' ');
    dlmwrite('matlab_chr2locs_out',chr2locs,' ');
    dlmwrite('matlab_expr_out',exprlevs,' ');
    nrncommand = ['C:\nrn73\bin\nrniv.exe -nobanner -c "mat_nseg='...
        sprintf('%f',tot_nseg)...
        '" locals_pop.hoc -c quit()'];
    dos(nrncommand);
    fprintf('Irradiance was %f \n', irrmags(1));
    fprintf('Expression was %f',exprlevs(1));
    retina(n).cells=importNeuron();
         if (find(retina(n).cells.vsoma(10:end)>0))
             set(somas(n),'FaceColor','r')
         else
            set(somas(n),'FaceColor',[.9 .9 .5])
         end
    retina(n).expr = exprlevs(1);
    
    irrmags = [];
    chr2locs = [];
end
