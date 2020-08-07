close all; clear; clc;

I = im2double(imread('E:\term6\machine vision\HW\HW3\Q2\Bridge.tif'));

In = imnoise(I, 'salt & pepper', 0.9);

w = 7;

J = My_denoising(In, w);

K = My_denoising_v2(In);

%K = medfilt2(In, [w w]);

imshow([I J K]);
psnr(J, I)
psnr(K, I)


