function [ retina ] = validate( irrparams, exprparams ,vcl,whichhoc)
ax_nseg = 20;

for a = 1:length(irrparams)
irrmags = [irrparams(a) 0 0 0 [1:ax_nseg].*0];
dlmwrite('matlab_irrmag_out',irrmags,' ');

chr2locs = [ 0.5 0.5 0.2 0.8 [1:ax_nseg]./ax_nseg-1./(2.*ax_nseg)];
dlmwrite('matlab_chr2locs_out',chr2locs,' ');

expressionlevels = [exprparams(a) 0 0 0 [1:ax_nseg].*0];
dlmwrite('matlab_expr_out',expressionlevels,' ');

dlmwrite('matlab_vcl_out',vcl(a),' ');

nrncommand = ['C:\nrn73\bin\nrniv.exe -nobanner -c "mat_nseg='...
    sprintf('%f',ax_nseg)...
    '" ' whichhoc ' -c quit()'];
dos(nrncommand);

retina(a)=importNeuron();
end