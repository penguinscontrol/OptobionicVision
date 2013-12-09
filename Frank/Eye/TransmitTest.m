%% TransmitTest.m
% Frank Lee

clear; close all

x = linspace(300,800,1000);
y1 = (1-exp(-(x-300)./30)).*(x-300).^(3/13);
max1 = max(y1);
y1 = 78/max1.*y1;
figure(1); clf
plot(x,y1,'k-')
hold on
xtest = [1 201 401 601 801 1000];
y1test = y1(xtest)

y2 = (1-exp(-(x-300)./35)).*(x-300).^(3/13);
max2 = max(y2);
y2 = 76/max2.*y2;
plot(x,y2,'b-')
y2test = y2(xtest)

y3 = (1-exp(-(x-300)./45)).*(x-300).^(3/13);
max3 = max(y3);
y3 = 75/max3.*y3;
plot(x,y3,'g-')
y3test = y3(xtest)

x2 = [zeros(1,200)+400 linspace(400,800,800)];
y4 = (1-exp(-(x-300)./70)).*(x-300).^(3/13).*(1-exp(-(x2-400)./10));
max4 = max(y4);
y4 = 65/max4.*y4;
plot(x,y4,'m-')
y4test = y4(xtest)

y5 = (1-exp(-(x-300)./110)).*(x-300).^(3/15).*(1-exp(-(x2-400)./10));%.*(1-exp(-(x2-400)./10));
max5 = max(y5);
y5 = 54/max5.*y5;
plot(x,y5,'r-')
y5test = y5(xtest)
title('Direct Transmittance')
xlabel('Wavelength (in nm)')
ylabel('Percent transmittance')
legend('Cornea','Aqueous','Lens','Vitreous','Retina',0)