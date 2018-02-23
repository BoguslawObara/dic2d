%% clear
clc; close all; clear all;

%% path
addpath('./lib');

%% load image
im = imread ('./im/dic_image.png');

%% setup
sl = 20;
nr = 180;
sd = 10;

%% dic segmentation
[imth,imh] = dic_segmentation2d(im,sl,nr,sd);

%% plot
figure; imagesc(im); colormap gray; 
set(gca,'ytick',[]); set(gca,'xtick',[]); axis image; axis tight;

figure; imagesc(imh); colormap jet; 
set(gca,'ytick',[]); set(gca,'xtick',[]); axis image; axis tight;

figure; imagesc(imth); colormap gray; 
set(gca,'ytick',[]); set(gca,'xtick',[]); axis image; axis tight;