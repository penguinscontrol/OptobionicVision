clear; clc; close all;

v = linspace(-1000,1000,5000);

grossman1 = @(x) (1-exp(-x./40))./(x./15);
grossman2 = @(x) (1-exp(x./43))./(-4.1);
abilez = @(x) (0.05.*x.^2-0.0692.*x+9.442);
williams = @(x) (10.6408-14.6408.*exp(-x./42.7671))./(x);

figure();
plot(v,grossman1(v));
title('grossman1');
figure();
plot(v,grossman2(v));
title('grossman2');
figure();
plot(v,abilez(v));
title('abilez');
figure();
plot(v,williams(v));
title('williams');