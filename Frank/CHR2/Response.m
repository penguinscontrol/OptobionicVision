%% CHR2.m
% Frank Lee

clear; close all


x = linspace(0,570,570*2);
alpha = 6;
beta = 2;
z = exp(-(x-475).^2./(2*60^2));
y = (2/0.067).*(x./570).^(alpha-1).*(1-(x./570)).^(beta-1);
w = y.*z;
figure(1);clf
plot(x,y,'k-')
hold on
plot(x,z,'b-')
plot(x,w,'g-')
plot(x,1/2.*y.^2,'r-')
%% maximum y is at index 833
% x(833) = 474 which is close to nm
% x(702) = 400 
% y(702) = 0.7574

index = find(y==max(y),1);

v = 1/2.*y.^2;

%% So I only want w from w(i) where i = 0 to 833, and y from 833 to 1000
response = [v(1:index) y(index+1:end)];
plot(x,response,'kx')

%% Subtract two and then take the exponent
temp = v;
temp = temp-2;
temp = exp(temp);
response = response-2;
response = exp(response);
plot(x,response,'mo')
plot(x,temp,'go')
axis([400 550 0 1])

