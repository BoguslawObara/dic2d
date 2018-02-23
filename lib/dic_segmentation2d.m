function [imth,imh] = dic_segmentation2d(im,sl,nr,sd)
%%  dic_segmentation2d 
%   
%   REFERENCE:
%       B. Obara, M. Roberts, J. Armitage, and V. Grau. 
%       Bioimage informatics approach for bacterial cells identification 
%       in Differential Interference Contrast microscopy images, 
%       BMC Bioinformatics, 14, 134, 2013
%   
%   INPUT:
%       im      - input image
%       sl      - line length, 20 
%       nr      - number of line rotations, 180 
%       sd      - disk size, 10 
%
%   OUTPUT:
%       imth    - segmented image
%       imh     - Hilbert image
%
%   AUTHOR:
%       Boguslaw Obara

%% normalize
im = double(im); im = (im - min(im(:))) / (max(im(:)) - min(im(:)));

%% DIC direction estimation
[a,as,v,p] = dic_direction2d(im,sl,nr);

%% Hilbert trnsform
ad = deg2rad(a) + pi/2;
imh = hilbert_transform2d(im,ad);
imh = real(imh);

%% tophat
se = strel('disk',sd);
imt = imtophat(imh,se);

%% normalize
imt = double(imt); imt = (imt - min(imt(:))) / (max(imt(:)) - min(imt(:)));

%% thresholding
imth = imt>graythresh(imt);

end