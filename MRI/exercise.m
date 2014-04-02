% --------------------------------------------------------------------
%Grant Nicholas MRI
%part(a)
%k-space data (.mat format) for this exercise
% -------------------------------------------------------------------- 
load('kspace_PD_weighted.mat');
load('kspace_T1_weighted.mat');
load('kspace_T2_weighted.mat');

% --------------------------------------------------------------------
% Size of data stored in matrix. The size of the the matrices are 240x240
% -------------------------------------------------------------------- 
[PDsy PDsx] = size(kspace_PD_weighted)
[T1sy T2sx] = size(kspace_T1_weighted)
[T2sy T2sx] = size(kspace_T2_weighted)


% --------------------------------------------------------------------
% Calculate absolute value of the data in the matrix
% -------------------------------------------------------------------- 
pdkMag = abs(kspace_PD_weighted)
t1kMag = abs(kspace_T1_weighted)
t2kMag = abs(kspace_T2_weighted)

%Draw images in kspace
hold on
subplot(1,4,1)
imagesc(log(pdkMag))
subplot(1,4,2)
imagesc(log(t1kMag))
subplot(1,4,3)
imagesc(log(t2kMag))

%part (b) do fourier transform of k space data
pdimageData = K2I(kspace_PD_weighted)
t1imageData = K2I(kspace_T1_weighted)
t2imageData = K2I(kspace_T2_weighted)

%take absolute value of image data
pdiMag = abs(pdimageData)
t1iMag = abs(t1imageData)
t2iMag = abs(t2imageData)

%part (c) display the PD, T1, T2 weighted images
figure
subplot(1,4,1)
imagesc(pdiMag)
subplot(1,4,2)
imagesc(t1iMag)
subplot(1,4,3)
imagesc(t2iMag)

%part (d)
%    T1   T2   PD
%WM  730  85   72
%GM  930  100  82
%CSF 1000 2000 100
%
%For the proton density weighted image, the brightness of the image is
%determined roughly by the amount of protons present in the tissue. Thus
%there is a good contrast between the gray matter with more protons (bright) 
%and the white matter with less protons(dark) but with little contrast 
%between the brain and CSF.
%For the T1 weighted image, materials with short T1's are bright in the 
%image. Thus, there is good contrast between gray matter with a high T1
%(darker) and white matter with a low T1(lighter), but there is not much
%contrast between the gray matter and the CSF or the white matter and the 
%CSF, which both have similar T1's.
%For the T2 weighted image,materials with short T2's are dark in the image.
%Thus there is good contrast between the CSF(lightet)
%and the gray and white matter (light) but not much contrast between the
%gray and white matter. 





