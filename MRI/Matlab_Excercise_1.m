
% Homework # 2
% Matlab Exercise
% --------------------------------------------------------------------

% --------------------------------------------------------------------
% General comments:
%
% Matlab 'help' function may be useful
%
% Make sure all .mat and .m files and your Matlab script 
% are in the same directory and that Matlab operates in this 
% directory (check with commands 'pwd' and 'ls')  
%
% Note 1: The code samples below are intended to help with generating
% the Matlab script for this exercise. These do not necessarily 
% represent the only or best way to complete the exercise. Feel free
% to try or use other commands if these work better for you.  
%
% Note 2: If this scrip is executed as is the code fragments below
% will result in errors. The data and 2D  matrices used in the code
% samples below have to be properly initialized 
% -------------------------------------------------------------------- 

% --------------------------------------------------------------------
% Load k-space data (.mat format) for this exercise
% -------------------------------------------------------------------- 
load('kspace_PD_weighted.mat');
load('kspace_T1_weighted.mat');
load('kspace_T2_weighted.mat');

% --------------------------------------------------------------------
% Size of data matrix stored in matrix 'data'
% -------------------------------------------------------------------- 
[sy sx] = size(data);

% --------------------------------------------------------------------
% Calculate absolute value of a complex number
% assuming complex data is stored in 2D matrix 'dataComplex'
% -------------------------------------------------------------------- 
dataMag = abs(dataComplex);

% --------------------------------------------------------------------
% Extract real and imaginary part of a complex number
% assuming complex data is stored in 2D matrix 'dataComplex'
% -------------------------------------------------------------------- 
dataReal = real(dataComplex);
dataImag = imag(dataComplex);

% --------------------------------------------------------------------
% Calculate Fourier Transform, k-space to image space
% assuming complex k-space data is stored in 2D matrix 'kspaceData'
% -------------------------------------------------------------------- 
imageData = K2I(kspaceData);

% --------------------------------------------------------------------
% Calculate inverse Fourier Transform, image space to k-space
% assuming complex image data is stored in 2D matrix 'imageData'
% -------------------------------------------------------------------- 
kspaceData = I2K(imageData);

% --------------------------------------------------------------------
% Display images side by side, 
% assuming image magnitude data is stored in 2D matrices 
% 'image1', 'image2', 'image3'  
% -------------------------------------------------------------------- 
figure;

subplot(1,3,1);   % generate subplot region in figure
imagesc(image1);  % display 2D image and scale to min and max
title('image #1') % title string that appears above image

subplot(1,3,2);
imagesc(image2);
title('image #1')

subplot(1,3,3);
imagesc(image3);
title('image #1')

colormap gray;  % change color map used for image display