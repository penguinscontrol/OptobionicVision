clear all; clc; close all;

nrncommand = ['C:\nrn73\bin\nrniv.exe -nobanner -c "double x[3] \n print x[1]" pass_vectors.hoc -c quit()'] %localcellopto.hoc -c quit()'];
dos(nrncommand);