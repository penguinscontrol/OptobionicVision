close all; clear
diam=30;

N_pixel=20; %total number of cells

%% Create a grid of the pixels
figure; hold on
irrvalue=linspace(.05,25,N_pixel);
exprvalue = linspace(1e-5,2e-2,N_pixel);%ones(1,N_pixel^2).*36e-4;
[irrad, expr] = meshgrid(irrvalue,exprvalue);

%% Generate the grid
posP = 0:N_pixel;
[gridx,gridy] = meshgrid(posP(1:(end-1)),flipud(posP(1:(end-1))));
gridy = flipud(gridy);
w=mean(diff(posP));
%% One cell per pixel
 for k=1:N_pixel.^2
        h(k)=rectangle('Position',[gridx(k) gridy(k) w,w],'EdgeColor','b');
 end
N_cell=N_pixel^2;

%% Randomized cell positions


axis([0 N_pixel 0 N_pixel]);
set(gca,'XTick',posP);
set(gca,'XTickLabel',irrvalue);
set(gca,'XTick',posP);
set(gca,'YTickLabel',exprvalue);
xlabel('Irradiances');
ylabel('Expression Levels');
retina=struct();

for n=1:N_cell
    
    nseg = 30;
    chr2locs = [0.5 0.5 0.2 0.8 [1:nseg]./nseg-1./(2.*nseg)];
    irrmags = [irrad(n) zeros(1,length(chr2locs)-1)];
    exprlevs = [expr(n) zeros(1,length(chr2locs)-1)];
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
             set(h(n),'FaceColor','r')
         else
            set(h(n),'FaceColor',[.9 .9 .5])
         end
    retina(n).expr = exprlevs(1);
    
    irrmags = [];
    chr2locs = [];
end

figure;
numplots = ceil(sqrt(N_cell));
for a = 1:length(retina)
    subplot(numplots,numplots,a);
    plot(retina(a).cells.vsoma);
    title(sprintf('%f',retina(a).expr));
end
