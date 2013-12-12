close all; clear
diam=20;
drawD=20;
cell=@(x,y) rectangle('Curvature',[1,1],'Position',[x y diam*drawD diam*drawD]);

gridmin=-12e3;
gridmax=12e3;
N_cell=700; %total number of cells

%% Create a grid of the pixels
figure; hold on
irrad=ImageProcess('Grill.jpg',15);
N_pixel=length(irrad);

%% Generate the grid
 posP=linspace(gridmin,gridmax,N_pixel+1);
 [gridx,gridy] = meshgrid(posP(1:(end-1)),flipud(posP(1:(end-1))));
 gridy = flipud(gridy);
 normIrr=max(max(irrad));
 w=mean(diff(posP));
 exprvalue = 0.004;
%% Randomized cell positions
posC=randi([gridmin gridmax-diam],N_cell,2);
 for k=1:N_pixel.^2
        h(k)=rectangle('Position',[gridx(k) gridy(k) w,w],'EdgeColor','k');
        set(h(k),'FaceColor',irrad(k)/normIrr*[1 1 1]);
 end
 for k=1:N_cell
     somas(k)=cell(posC(k,1),posC(k,2));
 end
axis([gridmin gridmax gridmin gridmax]);

retina=struct();

for n=1:N_cell
    %soma
    [irrSoma, locSoma]=findirrad(diam,1,posC(n,:),irrad,posP,N_pixel);
    %inital segment
    [irrIN, locIN]=findirrad(diam,1,[posC(n,1)+diam,posC(n,2)],irrad,posP,N_pixel);
    %Thin Segment
    [irrThin, locThin]=findirrad(60,2,[posC(n,1)+diam+30,posC(n,2)],irrad,posP,N_pixel);
    %Axon Segment
    axonL=gridmax-diam-90-posC(n,1);
    nseg = ceil(axonL/500);
    if axonL > 0
        [irrmags, chr2locs]=findirrad(axonL,nseg,[posC(n,1)+90+diam,posC(n,2)],irrad,posP,N_pixel);
    else
        irrmags = 0;
        chr2locs = 0.5;
        nseg = 1;
    end
    
    exprlevs = exprvalue.*[1 ones(1,length(irrIN)) ones(1,length(irrThin)) ones(1,length(irrmags))];
    
    irrmags = [irrSoma irrIN irrThin irrmags];
    chr2locs = [locSoma locIN locThin chr2locs];
    tot_nseg = length(irrmags);
    
    dlmwrite('matlab_irrmag_out',irrmags,' ');
    dlmwrite('matlab_chr2locs_out',chr2locs,' ');
    dlmwrite('matlab_expr_out',exprlevs,' ');
    nrncommand = ['C:\nrn73w64\bin64\nrniv.exe -nobanner -c "mat_nseg='...
        sprintf('%f',tot_nseg)...
        '" locals_pop.hoc -c quit()'];
    dos(nrncommand);
    fprintf('Irradiance was %f \n', irrmags(1));
    fprintf('Expression was %f',exprlevs(1));
    cells=importNeuron();
    figure(99);
    subplot(2,1,1)
    plot(cells.vsoma)
    title('V Soma')
    subplot(2,1,2)
    plot(cells.vaxon);
    title('V Axon')
    pks = findpeaks(cells.vaxon,'MINPEAKHEIGHT',-20,'MINPEAKDISTANCE',40);
    pkssoma = findpeaks(cells.vsoma,'MINPEAKHEIGHT',-20,'MINPEAKDISTANCE',40);
         if (length(pks)>0)
             if (length(pks)>10);
%                  if(length(pks)==1 & length(pkssoma)>1)
%                      set(somas(n),'FaceColor','m')
                 if (length(pks)>length(pkssoma))
                    set(somas(n),'FaceColor','g')
                    %set(somas(n),'Curvature',[0 0])
                 elseif (length(pks)<length(pkssoma))
                    set(somas(n),'FaceColor','b')
                    %set(somas(n),'Curvature',[0 0])
                 elseif (length(pks)==length(pkssoma))
                     set(somas(n),'FaceColor','c')
                     %set(somas(n),'Curvature',[0 0])
                 else
                     set(somas(n),'FaceColor','y')
                     %set(somas(n),'Curvature',[0 0])
                 end
             else
                 if(length(pkssoma)>1)
                     set(somas(n),'FaceColor','m')
                 else
                    set(somas(n),'FaceColor','r')
                 end
             end
            %good=irrad(n);
         else
            set(somas(n),'FaceColor',[.9 .9 .5])
            % fails=fails+1;
            % bad=irrad(n);
         end
    
    irrmags = [];
    chr2locs = [];
end