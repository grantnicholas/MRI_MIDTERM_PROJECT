load('data_heart.mat');
[sy sx st] = size(data_heart);

%loads each time slice, performs the K2I transform and then saves the image
%as variable names: image_data1, image_data2, image_data3 etc

for t = 1:25
   eval(sprintf('image_data%d = data_heart(1:sy,1:sx,t)', t));
   eval(sprintf('k_data = I2K(image_data%d)', t));
   eval(sprintf('k_data%d = k_data', t));
   eval(sprintf('image_data = K2I(k_data%d)',t)); %
   eval(sprintf('image_data%d = image_data',t));  %
   k_data_top = k_data1(1:sy/4,1:sx);
   k_data_bot = k_data1(3*sy/4:sy,1:sx);
   eval(sprintf('k_data_mid = k_data%d(1+sy/4:(3*sy/4)-1,1:sx)', t));
   eval(sprintf('k_data_mid%d = k_data_mid', t));
   eval(sprintf('k_data_new = [k_data_top;k_data_mid%d;k_data_bot]', t));
   eval(sprintf('k_data_new%d = k_data_new', t));
   eval(sprintf('image_data_new = K2I(k_data_new%d)', t));
   eval(sprintf('image_data_new%d = image_data_new', t));
   
    eval(sprintf('di1 = image_data%d',t));
    eval(sprintf('di2 = image_data_new%d',t));
    difference_image = di1 - di2;
   
   figure;
   subplot(1,3,1);
   eval(sprintf('imagesc(abs(image_data%d))',t));
   subplot(1,3,2);
   eval(sprintf('imagesc(abs(image_data_new%d))',t));
   subplot(1,3,3);
   imagesc(abs(difference_image)); 
end


% Questions:
% Original and view sharing images are similar because both the original and
% view sharing images utilize the same middle 50% of kspace
% (in the phase direction). The only difference between the two images is 
% that the view sharing images utilize the "top" and "bottom" of the first 
% time slice image in kspace instead of the actual top and bottom of kspace 
% at the current time slice. This results in a slight distortion of the 
% view sharing images, as seen in series of difference images. 
% 
% The large difference in the top and bottom of kspace ,however, 
% do not have a large effect on the relative images as seen in the series of
% difference images. This is so as the differences in kspace are near the 
% edges of kspace, where generally the high frequency information regarding 
% image resolution resides. Thus, as the low frequency components containing
% the signal to noise and contrast information are primarily found near the 
% center of kspace and these are kept intact for the view sharing images,in
% general the view sharing images very accurately reproduce the normal
% images. 
% 
% View sharing could be used for rapid image acceleration because only 1
% complete kspace time slice needs to be taken for a series of images. 
% For the rest of the images, only half of kspace needs to be acquired. Thus
% the time needed to take a series of images using view sharing is cut by
% around half over standard MRI techniques. Thus, for applications in which
% the high frequency image resolution information is not very important or
% does not change much relative to the low frequency signal to noise and
% contrast information,view sharing can drastically speed up MRI data acq 
% with few drawbacks. 




