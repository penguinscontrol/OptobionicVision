clear;clc;close all;

figure();
hold all;
items = {'vc1','vc2','vc3','vc4','vc5','vc6','vc7','vc8','vc9','vc10'};
vdep = @(x) (1-exp(-x./40))./(x./15);
for a = 1:10
    load(items{a});
    plot(data.t,data.iopt);
end