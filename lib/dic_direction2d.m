function [amu,a,v,p] = dic_direction2d(im,s,nr)
%%  dic_direction2d - direction of phase in DIC images
%   
%   REFERENCE:
%       SOON :)
%
%   INPUT:
%       im  - image
%       s   - line length
%       nr  - number of rotations
%
%   OUTPUT:
%       amu - DIC direction angle [deg] 
%       a   - angles [deg]
%       v   - sum of gradients for each direction
%       p   - Von Mises function parameters
%
%   AUTHOR:
%       Boguslaw Obara

%% find direction of the phase 
a = (0:180/nr:180-180/nr)';
v = zeros(length(a),1);
for i=1:length(a)
    se = strel('line',s,a(i));
    imgrad = imdilate(im,se) - imerode(im,se);
    v(i) = max(imgrad(:));
    % v(i) = sum(imgrad(:));
    % v(i) = mean(imgrad(:));
end

%% scale data
v = v/max(v(:)); % [0,1]
x = (-pi + 2*pi*(0:180/nr:180-180/nr)/180)'; % [0,180] -> [-pi,pi]
y = v;

%% fit Von Mises function
ps = rand(1,3);
ps(3) = x(find(y==max(y),1));
options = optimset('Display','off');
p = fminsearch(@von_mises_fit,ps,options,x,y);
amu = 180*(p(3) + pi)/(2*pi); % [-pi,pi] -> [0,180]

end