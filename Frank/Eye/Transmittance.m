%% Transmittance

clear; close all

%% Cornea
x = linspace(300,800,1000);
y1 = ((x-300)).^(1/4);
max1 = max(y1);
y1 = 78/max1.*y1;
figure(1); clf
plot(x,y1,'k-')
hold on
title('Transmittance')
xtest = [1 201 401 601 801 1000];
y1test = y1(xtest)

%% Aqueous
y2 = ((x-300)).^(1/4);
max2 = max(y2);
y2 = 76/max2.*y2;
plot(x,y2,'b-')
y2test = y2(xtest)

