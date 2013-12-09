%% Trichromatic Peaks
% Frank Lee

clear; close all
wavelength = linspace(380,750,1000);
sigma = 10.6165;
a = 60;
b = 180;
c = 240;
k = 2.1748845;
red = k.*a*1/255*(1/sqrt(2*pi*10.6165^2)).*exp(-(wavelength-650).^2./(2.*sigma.^2));
green = k.*b*1/255*(1/sqrt(2*pi*10.6165^2)).*exp(-(wavelength-532).^2./(2.*sigma.^2));
blue = k.*c*1/255*(1/sqrt(2*pi*10.6165^2)).*exp(-(wavelength-473).^2./(2.*sigma.^2));

%% Plot
figure(1); clf
plot(wavelength,red,'r-')
hold on
plot(wavelength,green,'g-')
plot(wavelength,blue,'b-')
title('Individual Peaks')
xlabel('Wavelength (in nm)')
ylabel('Normalized intensity')

%% Summation
LED = red + green + blue 
plot(wavelength,LED,'k:')