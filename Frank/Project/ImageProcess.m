function [result]=ImageProcess(photo,pixel_dim)

% Mother.m
% Frank Lee

% clear; close all

%% Assume a 1x1 square meter bright white LCD monitor (R=G=B=255);
% Use a 1x1 square meter with 15x15 resolution
% pixel_dim = 15;
% map = zeros(pixel_dim,pixel_dim,3);
% map(6:10,6:10,3) = 255; % blue square
% map(:,:,3) = 255; % all blue scene
% map(:,:,2) = 255; % all green scene
% map(:,:,1) = 255; % all red scene
% map = map + 255; % all white scene

% Duke D
% map(:,:,3) = 150;
% map(1:15,1,:) = 255;
% map(1,1:15,:) = 255;
% map(15,1:15,:) = 255;
% map(1:15,15,:) = 255;
% map(3:13,2,:) = 255;
% map(4:12,3,:) = 255;
% map(4:12,7,:) = 255;
% map(3:13,8,:) = 255;
% map(3:13,9,:) = 255;
% map(4:12,10,:) = 255;
% map(2,13,:) = 255;
% map(14,13,:) = 255;
% map(2:3,14,:) = 255;
% map(13:14,14,:) = 255;
% image(map/255);

% Random
% map = randi(255,15,15,3);

% Color Spectrum
% color_spec = imread('Color_Spectrum.jpg');
% map = double(imresize(color_spec, [15 15]));
% image(map/255);

% Warren Grill
% grill = imread('Grill.jpg');
% map = double(grill);
% % image(map/255);
% row = size(map,1);
% col = size(map,2);
% if (row<col) 
%     pixel_dim=row;
% else
%     pixel_dim=col;
% end

% Marc Sommer
% sommer = imread('Sommer.jpg');
% map = double(imresize(sommer, [15 15]));
pho = imread(photo);
if nargin==1
    map = double(pho);
% image(map/255);
row = size(map,1);
col = size(map,2);
if (row<col) 
    pixel_dim=row;
else
    pixel_dim=col;
end
else 
    map = double(imresize(pho, [pixel_dim pixel_dim]));
end




    


%% Image source used is a one by one meter with 225 pixels. 
% Object distance is 1 meter away 
% Image distance needs to be the horizontal diameter of the eye = 24 mm
% Focal distance is therefore 23.438 mm
% Magnification is 24/1000 or 0.024x
% As a result, image size is 24 mm x 24 mm
% The entire area of the retina is 1094 mm^2 and if we assume it to be ...
% ... circular, then the radius is 17 mm. 

% So the 5x5 square is: 1/3 m x 1/3 m (333 mm x 333 mm)
% The image on the retina is 333/24 mm x 333/24 mm (13.875 mm x 13.875 mm)

wavelength = linspace(300,800,1000);
sigma = 10.6165; % produces a 25 nm FWHM 
brightness = 350; % candelas/square meter for our source
% pixel_max = brightness/pixel_dim^2; % candela contribution per pixel
source_irr = brightness./683./(pi*(0.005/2)^2)/1000; % mW/mm^2
max_rad_per_pixel = source_irr.*(1000/pixel_dim)^2; %mW/pixel
max_rad_per_led = max_rad_per_pixel/3; %mW per LED 

% total_red = 0;
% total_green = 0;
% total_blue = 0;
% 
% for k=1:pixel_dim
%     for l = 1:pixel_dim
%         total_red = total_red + map(k,l,1);
%         total_green = total_green + map(k,l,2);
%         total_blue = total_blue + map(k,l,3);
%     end
% end
% 
% avg = total_red/pixel_dim^2;
% avg_green = total_green/pixel_dim^2;
% avg_blue = total_blue/pixel_dim^2;

% Declare the intensity spectrum for red, green and blue component 
% as well as total LED spectral intensity
red = zeros(pixel_dim,pixel_dim,length(wavelength));
green = zeros(pixel_dim,pixel_dim,length(wavelength));
blue = zeros(pixel_dim,pixel_dim,length(wavelength));
LED = zeros(pixel_dim,pixel_dim,length(wavelength));
irr_LED_test = zeros(pixel_dim,pixel_dim,length(wavelength));

for k=1:pixel_dim
    for l=1:pixel_dim
        red(k,l,:) = max_rad_per_led.*map(k,l,1)/255*(1/sqrt(2*pi*10.6165^2)).*exp(-(wavelength-650).^2./(2.*sigma.^2));
        green(k,l,:) = max_rad_per_led.*map(k,l,2)/255*(1/sqrt(2*pi*10.6165^2)).*exp(-(wavelength-532).^2./(2.*sigma.^2));
        blue(k,l,:) = max_rad_per_led.*map(k,l,3)/255*(1/sqrt(2*pi*10.6165^2)).*exp(-(wavelength-473).^2./(2.*sigma.^2));
        LED(k,l,:) = red(k,l,:)+green(k,l,:)+blue(k,l,:);
        irr_LED_test(k,l) = max(cumtrapz(wavelength,LED(k,l,:)));
    end
end


%% Transmittance through Eye (post-Retina)
x = [zeros(1,200)+400 linspace(400,800,800)];
y_retina = (1-exp(-(wavelength-300)./110)).*(wavelength-300).^(3/15).*(1-exp(-(x-400)./10));
max5 = max(y_retina); %Normalize sensitivity
y_retina = 54/max5.*y_retina; %Maximum of 0.54 (see literature)

% Declare the frequency spectrum for irradiance post-retina
post_transmittance = zeros(pixel_dim,pixel_dim,length(wavelength));
for k = 1:pixel_dim
    for l = 1:pixel_dim
        for m = 1:length(wavelength)
            post_transmittance(k,l,m) = LED(k,l,m).*y_retina(m)./100;
        end
    end
end


%% Channelrhodopsin Response
% wavelength = linspace(300,800,1000);
alpha1 = 30;
beta1 = 21;
y1 = (wavelength./800).^(alpha1-1).*(1-(wavelength./800)).^(beta1-1);
y1 = 1/max(y1).*y1; %Normalize
% Troubleshoot
freq_at_peak = wavelength(find(y1==max(y1)));
abs_at_400 = y1(find(wavelength>400,1));

y2 = y1.^(1.6);
y2 = 1/max(y2).*y2;
% Troubleshoot
abs_at_550 = y2(find(wavelength>550,1));

y3 = exp(-(wavelength-295)/10);
y_13 = y1+y3;
y_13 = 1/max(y_13).*y_13;
y_all = [y_13(1:find(y_13==max(y_13))) y2(find(y_13==max(y_13))+1:end)];

% Declare the frequency spectrum for irradiance post-CHR2
post_chr2 = zeros(pixel_dim,pixel_dim,length(wavelength));
irr_pixel = zeros(pixel_dim,pixel_dim);

for k = 1:pixel_dim
    for l = 1:pixel_dim
        for m = 1:length(wavelength)
            post_chr2(k,l,m) = post_transmittance(k,l,m).*y_all(m);
        end
        % Calculate the irradiance per pixel
        irr_pixel(k,l) = max(cumtrapz(wavelength,post_chr2(k,l,:)));
    end
end

%% Convert to Irradiance units of mW/mm^2
irr = irr_pixel./(1000/pixel_dim)^2;
% imagesc(irr);
% colorbar;

%% Image Transformation (Invert and Flip)
result = zeros(pixel_dim,pixel_dim);
for k = 1:pixel_dim
    for l = 1:pixel_dim
        result(k,l) = irr(pixel_dim+1-k,pixel_dim+1-l);
    end
end
imagesc(result)
colormap gray
colorbar


