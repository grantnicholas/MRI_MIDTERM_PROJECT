% Grant Nicholas MRI Pset #3

%part(a)
load('kspace_heart.mat');

heartimageData = K2I(kspace_heart);

figure
subplot(1,4,1)
imagesc(log(abs(kspace_heart)))
colormap(gray)
subplot(1,4,2)
imagesc((abs(heartimageData)))
colormap(gray)

%part(b)

[hisy hisx] = size(heartimageData)
%Thus the image size is hisx = 192; hisy = 156



%Spatial resolution of image = FOV/image size
fovx = 340; fovy = 280;
srX = fovx/hisx
srY = fovy/hisy
%srX = 1.7708; srY = 1.7949

%since we know the matrix size of kspace and the image are the same
kxmax = 192; kymax = 156;
%FOVx = 1/(del kx); FOVy = 1/(del ky)
delkx = 1/fovx
delky = 1/fovy
%delkx = 0.0029 1/mm ; delky = 0.0036 1/mm

%part(c)
%simulate undersampling by removing odd samples from kspace
samplekspace_heart = kspace_heart;
for i = 1:kymax
    if mod(i,2)~= 0
        for j = 1:kxmax
            samplekspace_heart(i,j) = 0;
        end
    end
end
%removing half of the kspace data in the y direction multiplies delky by 2
%does not effect delkx
delky = 2*delky;
%delkx = 0.0029 1/mm  delky = 0.0072 1/mm
fovy = 1/(delky)
%fovx = 340mm; fovy = 140mm;

sampleheartimageData = K2I(samplekspace_heart);

figure;
subplot(1,4,1)
imagesc(log(abs(samplekspace_heart)))
colormap(gray)
subplot(1,4,2)
imagesc((abs(sampleheartimageData)))
colormap(gray)

%Increasing delky in kspace (by simulating undersampling along the phase
%encoding direction y) causes a decrease in the FOV in only the y direction
%of the image from 280mm to 140mm. This decrease in FOV in the y direction
%causes the FOVy<Object size, meaning that aliasing occurs and three
%versions of the object are present in the image with an overlap. It is
%important to note this overlap only occurs in the y direction, as the
%system is still properly sampled in the x direction. 

%part(d)

%We want to trim kspace to kspace_heart(c:d,a:b) for the middle z% data. 
%That is equivalent to finding the solution to the system 
%(192/156) = (x/y); x*y=(192*156)*.80; a = (192-x)/2; b = 192-a; 
%c = (156-y)/2; d=156-c; for z = .10,.20,.50,.80
%z = .10, x = 61, y = 49 ; a = 66; b = 126; c = 53; d = 103;
%z = .20, x = 86, y = 70 ; a = 53; b = 139; c = 43; d = 113;
%z = .50, x = 136,y = 110; a = 28; b = 164; c = 23; d = 133;
%z = .80, x = 172,y = 140; a = 10; b = 182; c = 8;  d = 148;

tenkspace = kspace_heart;
twentykspace = kspace_heart;
fiftykspace = kspace_heart;
eightykspace = kspace_heart;
for i = 1:53
    for j = 1:kxmax
        tenkspace(i,j) = 0;
    end
end
for i = 103:kymax
    for j = 1:kxmax
        tenkspace(i,j) = 0;
    end
end
for j = 1:66
    for i = 1:kymax
        tenkspace(i,j) = 0;
    end
end
for j = 126:kxmax
    for i = 1:kymax
        tenkspace(i,j) = 0;
    end
end


for i = 1:43
    for j = 1:kxmax
        twentykspace(i,j) = 0;
    end
end
for i = 113:kymax
    for j = 1:kxmax
        twentykspace(i,j) = 0;
    end
end
for j = 1:53
    for i = 1:kymax
        twentykspace(i,j) = 0;
    end
end
for j = 139:kxmax
    for i = 1:kymax
        twentykspace(i,j) = 0;
    end
end

for i = 1:23
    for j = 1:kxmax
        fiftykspace(i,j) = 0;
    end
end
for i = 133:kymax
    for j = 1:kxmax
        fiftykspace(i,j) = 0;
    end
end
for j = 1:28
    for i = 1:kymax
        fiftykspace(i,j) = 0;
    end
end
for j = 164:kxmax
    for i = 1:kymax
        fiftykspace(i,j) = 0;
    end
end

for i = 1:8
    for j = 1:kxmax
        eightykspace(i,j) = 0;
    end
end
for i = 148:kymax
    for j = 1:kxmax
        eightykspace(i,j) = 0;
    end
end
for j = 1:10
    for i = 1:kymax
        eightykspace(i,j) = 0;
    end
end
for j = 182:kxmax
    for i = 1:kymax
        eightykspace(i,j) = 0;
    end
end

%tenkspace = kspace_heart(53:103,66:126);
%twentykspace = kspace_heart(43:113,53:139);
%fiftykspace = kspace_heart(23:133,28:164);
%eightykspace = kspace_heart(8:148,10:182);

[tksy tksx] = size(tenkspace)
[twksy twksx] = size(twentykspace)
[fksy fksx] = size(fiftykspace)
[eksy eksx] = size(eightykspace)
%The extent of kspace for ten (tk), twenty(twk), fifty(fk), eighty(ek)
% tksy = 51
% tksx = 61
% twksy= 71
% twksx= 87
% fksy = 111
% fksx = 137
% eksy = 141
% eksx = 173
%As we trimmed the kspace data, we see a reduction in (nonzero)kspace size

%We know the size of the kspace and image space matrices are the same
%Thus we know the spatial resolution sr = FOV/ks

srtx = fovx/tksx; srty = fovy/tksy; srtwx = fovx/twksx; srtwy = fovy/twksy; 
srfx = fovx/fksx; srfy = fovy/fksy; srex = fovx/eksx; srey = fovy/eksy; 

%srtx = 5.5738; srty = 5.4902; srtwx = 3.9080; srtwy = 3.9437; 
%srfx = 2.4818; srfy = 2.5225; srex  = 1.9653; srey  = 1.9858;
%We see a clear pattern. At higher kspace sampling the resolution of the
%image is much greater than at lower kspace sampling. This makes sense as
%kspace and image space have the same number of entries so by sampling more
%of kspace we are effectively getting more "pixels" in image space so our
%spatial resolution should increase.

%The field of view is still the same so delkx and delky remain unchanged
fovx = 340; fovy = 280;
delkx = 1/fovx
delky = 1/fovy
%delkx = 0.0029 1/mm ; delky = 0.0036 1/mm

figure
subplot(4,2,1)
imagesc(log(abs(tenkspace)))
colormap(gray)
subplot(4,2,2)
imagesc(abs(K2I(tenkspace)))
colormap(gray)
subplot(4,2,3)
imagesc(log(abs(twentykspace)))
colormap(gray)
subplot(4,2,4)
imagesc(abs(K2I(twentykspace)))
colormap(gray)
subplot(4,2,5)
imagesc(log(abs(fiftykspace)))
colormap(gray)
subplot(4,2,6)
imagesc(abs(K2I(fiftykspace)))
colormap(gray)
subplot(4,2,7)
imagesc(log(abs(eightykspace)))
colormap(gray)
subplot(4,2,8)
imagesc(abs(K2I(eightykspace)))
colormap(gray)



%From the images, we can see a clear relationship between kspace and the
%image space. Even though delkx and delky (the resolution of kspace) has
%not changed at all, we see the spatial resolution of image space greatly
%increased. Likewise, although the amount of kspace (field of view of
%kspace) was increased from 10-->100% we see that the field of view of
%image space was not affected at all. We see that kspace and image space
%are sort of reciprocals to each other. By increasing the field of view of
%one, you increase the spatial resolution of the other[and vice versa]. 

            
    




