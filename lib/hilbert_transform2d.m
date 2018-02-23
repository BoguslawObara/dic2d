function [imh,h] = hilbert_transform2d(im,theta)
%%  hilbert_transform2d - design Hilbert kernel in Fourier domain
%   
%   REFERENCE:
%       G. H. Granlund and H. Knutsson, 
%       Signal Processing for Computer Vision, 
%       The Netherlands, Kluwer, 1995.
%
%   INPUT:
%       im      - image
%       theta   - orientation
%
%   OUTPUT:
%       imh     - image after Hilbert transform
%       h       - Hilbert kernel
%
%   AUTHOR:
%       Boguslaw Obara

%% coordinaties
% set up X and Y matrices with ranges normalised to +/- 0.5
% the following code adjusts things appropriately for odd and even values
% of rows and columns.
[xn,yn] = size(im);
if mod(xn,2); 
    xr = -(xn-1)/2:(xn-1)/2;
else
    xr = -xn/2:(xn/2-1); 
end
if mod(yn,2)
    yr = -(yn-1)/2:(yn-1)/2;
else
    yr = -yn/2:(yn/2-1); 
end
[x,y] = ndgrid(xr,yr); % grid

%% direction
n = [cos(theta) sin(theta)]; % unit vector

%% dot product
xc = reshape(x,1,[]); 
yc = reshape(y,1,[]);
u = [xc; yc]';
un = u*n';
unr = reshape(un,xn,yn);

%% sign
h = 1i*sign(unr);

%% Fourier transform using the shift operations
imfft = fftshift(fft2(ifftshift(im)));  

%% Hilbert transform
imfft = h.*imfft;

%% inverse Fourier transform using the shift operations
imh = fftshift(ifft2(ifftshift(imfft)));

end



% x = -10:10;
% H = 1i*sign(x);
% Hr = fftshift(ifft(ifftshift(H)));
% plot(Hr)


