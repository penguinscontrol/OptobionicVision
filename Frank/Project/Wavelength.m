clear;

im_rgb = imread('Duke Logo.jpg'); % saves as RGB
im_hsv = rgb2hsv(im_rgb); % converts to HSV map
% wavelength = 650-im_hsv(:,:,1)/(240/650-475);

% Test
figure(1); clf
image(im_rgb(200:300,300:400,:));

figure(2); clf
one = im_rgb(200:300,300:400,1);
imagesc(one);
colorbar;
figure(3); clf
two  = im_rgb(200:300,300:400,2);
imagesc(two);
colorbar;
figure(4); clf
temp = zeros(101,101)+150;
%imagesc(im_rgb(200:300,300:400,3));
imagesc(temp);
colorbar;

close all

figure(5);
tempfig = zeros(101,101,3);
tempfig(:,:,1) = one;
tempfig(:,:,2) = two;
tempfig(:,:,3) = temp;
image(tempfig./255);

%% Rhodopsin Channel
% NA = 6.02e23;
% phi = NA*

wavelength = linspace(380,750,1000);
sigma = 10.6165;
a = double(im_rgb(250,350,1));
b = double(im_rgb(250,350,2));
c = double(im_rgb(250,350,3));
red = a.*1./255.*exp(-(wavelength-650).^2./(2.*sigma.^2));
green = b.*1/255*exp(-(wavelength-532).^2./(2.*sigma.^2));
blue = c.*1/255*exp(-(wavelength-473).^2./(2.*sigma.^2));

%% Plot
figure(1); clf
plot(wavelength,red,'r-')
hold on
plot(wavelength,green,'g-')
plot(wavelength,blue,'b-')
title('Individual Peaks')
xlabel('Wavelength (in nm)')
ylabel('Normalized intensity')
