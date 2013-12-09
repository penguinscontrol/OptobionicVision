%% CHR2.m
% Frank Lee

clear; close all


x1 = linspace(300,800,1000);
alpha1 = 30;
beta1 = 21;
y1 = (x1./800).^(alpha1-1).*(1-(x1./800)).^(beta1-1);
y1 = 1/max(y1).*y1;
freq_at_peak = x1(find(y1==max(y1)))
abs_at_400 = y1(find(x1>400,1))

y2 = y1.^(1.6);
y2 = 1/max(y2).*y2;
abs_at_550 = y2(find(x1>550,1))

y3 = exp(-(x1-295)/10);
y_13 = y1+y3;
y_13 = 1/max(y_13).*y_13;
y_all = [y_13(1:find(y_13==max(y_13))) y2(find(y_13==max(y_13))+1:end)]
% w = y.*z;
figure(1);clf
plot(x1,y1,'k-')
hold on
plot(x1,y2,'b-')
plot(x1,y3,'r-')
plot(x1,y_13,'c-')
plot(x1,y_all,'g-')
axis([300 800 0 1])

% 
% x2 = linspace(0,570,1000);
% alpha2 = 6;
% beta2 = 2;
% y2 = (x2./570).^(alpha2-1).*(1-(x2./570)).^(beta2-1);
% 
% plot(x2,y2,'b-')
% plot(x,z,'b-')
%plot(x,w,'g-')
% plot(x,1/2.*y.^2,'r-')
%% maximum y is at index 833
% x(833) = 474 which is close to nm
% x(702) = 400 
% y(702) = 0.7574

% v = 1/2.*y.^2;
% 
% %% So I only want w from w(i) where i = 0 to 833, and y from 833 to 1000
% response = [v(1:833) y(834:1000)];
% plot(x,response,'kx')
% 
% %% Subtract two and then take the exponent
% temp = v;
% temp = temp-2;
% temp = exp(temp);
% response = response-2;
% response = exp(response);
% plot(x,response,'mo')
% plot(x,temp,'go')
% % axis([300 570 0 1])

% x = linspace(0,570,570*2);
% alpha = 6;
% beta = 2;
% z = exp(-(x-475).^2./(2*60^2));
% y = (2/0.067).*(x./570).^(alpha-1).*(1-(x./570)).^(beta-1);
% w = y.*z;
% figure(1);clf
% plot(x,y,'k-')
% hold on
% plot(x,z,'b-')
% plot(x,w,'g-')
% plot(x,1/2.*y.^2,'r-')
% %% maximum y is at index 833
% % x(833) = 474 which is close to nm
% % x(702) = 400 
% % y(702) = 0.7574
% 
% index = find(y==max(y),1);
% 
% v = 1/2.*y.^2;
% 
% %% So I only want w from w(i) where i = 0 to 833, and y from 833 to 1000
% response = [v(1:index) y(index+1:end)];
% plot(x,response,'kx')
% 
% %% Subtract two and then take the exponent
% temp = v;
% temp = temp-2;
% temp = exp(temp);
% response = response-2;
% response = exp(response);
% plot(x,response,'mo')
% plot(x,temp,'go')
% axis([300 570 0 1])


