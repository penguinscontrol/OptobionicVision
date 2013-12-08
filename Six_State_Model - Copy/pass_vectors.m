clear all; clc; close all;

ax_nseg = 20;

irrmags = [0 0 0 0 [1:ax_nseg].*0];
irrmags(1) = 1;
dlmwrite('matlab_irrmag_out',irrmags,' ');

chr2locs = [ 0.5 0.5 0.2 0.8 [1:ax_nseg]./ax_nseg-1./(2.*ax_nseg)];
dlmwrite('matlab_chr2locs_out',chr2locs,' ');

expressionlevels = [45e-3 0 0 0 [1:ax_nseg].^0.*0];
dlmwrite('matlab_expr_out',expressionlevels,' ');

nrncommand = ['C:\nrn73\bin\nrniv.exe -nobanner -c "mat_nseg='...
    sprintf('%f',ax_nseg)...
    '" pass_vectors_test.hoc -c quit()'];
dos(nrncommand);