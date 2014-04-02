% Grant Nicholas MRI Pset #4

%part(a)
load('image_heart_T2prep_0.mat');
load('image_heart_T2prep_24.mat');
load('image_heart_T2prep_55.mat');

figure
subplot(1,4,1)
imagesc(abs(sqrt(image_heart_T2prep_0)))
colormap(gray)
subplot(1,4,2)
imagesc(abs(sqrt(image_heart_T2prep_24)))
colormap(gray)
subplot(1,4,3)
imagesc(abs(sqrt(image_heart_T2prep_55)))
colormap(gray)

%As the T2prep time increases from 0ms to 24ms and finally 55ms, the signal
%and contrast of the resulting images appear to change drastically. In the
%low prep time image, there is more signal present (which makes sense as
%there is less time for T2 decay to occur). However, there is only a
%moderate amount of contrast in the low T2prep time image. For the high
%T2prep time image there is less raw signal as more T2 decay occurs due to
%the longer T2prep time. However, the increased T2 decay highlights
%contrast between different structures in the heart, which is especially
%apparent in the 55ms image. Effectively there is a balance between losing
%signal and gaining contrast from increasing prep time that must balanced
%in order to obtain the best image.

%part (b)

[sy sx] = size(image_heart_T2prep_0);
newimage = abs(image_heart_T2prep_0);
M0 = abs(image_heart_T2prep_0);
x = [0;24;55];
for j= 1:sy
    for i = 1:sx
        y =[abs(image_heart_T2prep_0(j,i));abs(image_heart_T2prep_24(j,i));abs(image_heart_T2prep_55(j,i))];
        f = fit(x,y,'exp1');
        M0(j,i) = f.a;
        newimage(j,i) = f.b; 
    end
end

%Newimage gives us the exponent in Signal = M0*e^(a*T2prep)
%However, the actual equation is Signal = M0*e^(-1/T2 *T2prep)
%To convert the "a" exponent constant to T2 need to invert and change the
%sign of "a"
newimage2 = -1./newimage;

%Display and use log for more contrast
imagesc(log(abs(newimage2)))
colormap(gray)



    
    

        
        
       