%% ImageTransformation.m
% Frank

clear; close all

im_rgb = imread('Duke Logo.jpg'); % saves as RGB

% Use a 1x1 square meter with 15x15 resolution
map = zeros(15,15,3);
map(6:10,6:10,3) = 255; % blue 

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
