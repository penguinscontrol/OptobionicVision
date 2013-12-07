clear all; clc; close all;

nseg = 20;
irrmags = [1:nseg].*40;
dlmwrite('matlab_irrmag_out',irrmags,' ');

chr2locs = [1:nseg]./nseg-1./(2.*nseg);
dlmwrite('matlab_chr2locs_out',chr2locs,' ');

nrncommand = ['C:\nrn73\bin\nrniv.exe -nobanner -c mat_nseg="' sprintf('%f',nseg) '" pass_vectors.hoc -c quit()'];
dos(nrncommand);