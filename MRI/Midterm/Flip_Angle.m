%Grant Nicholas
%regions marked on the printed images 
%mean and std calculations at the end of the code

avgr1 = [];
avgr2 = [];
avgr3 = [];
contrast12 = [];
contrast23 = [];
contrast31 = [];
for i = 10:10:90
    matFilename = sprintf('t1_fl2d_tra_%d flip angle.mat', i);
    load(matFilename);
    %region 1 center of middle object
    [avg1 std1] = Region(imagedata,160,190,110,140);
    [avg2 std2] = Region(imagedata,100,130,20,50);
    [avg3 std3] = Region(imagedata,65,100,170,190);
    
    figure;
    imagesc(imagedata);
    colormap(gray);
    avgr1(end+1) = avg1;
    avgr2(end+1) = avg2;
    avgr3(end+1) = avg3;

    
    contrast12(end+1) = abs(avg1-avg2)/(avg1+avg2); %std12 = sqrt(std1^2 + std2^2);
    contrast23(end+1) = abs(avg2-avg3)/(avg3+avg2); %std23 = sqrt(std2^2 + std3^2);
    contrast31(end+1) = abs(avg3-avg1)/(avg3+avg1); %std31 = sqrt(std3^2 + std1^2);
    
    
end

%signal
figure;
subplot(1,3,1);
plot(10:10:90, avgr1);
xlabel('Flip angle (degrees)'); ylabel('Signal intensity');
title('Water');
subplot(1,3,2);
plot(10:10:90, avgr2);
xlabel('Flip angle (degrees)'); ylabel('Signal intensity');
title('Oil');
subplot(1,3,3);
plot(10:10:90, avgr3);
xlabel('Flip angle (degrees)'); ylabel('Signal intensity');
title('Grapefruit');

%contrast
figure;
subplot(1,3,1);
plot(10:10:90, contrast12);
title('Water/Oil'); xlabel('Flip angle (degrees)'); ylabel('Signal contrast');
subplot(1,3,2);
plot(10:10:90, contrast23);
title('Oil/Grapefruit');xlabel('Flip angle (degrees)'); ylabel('Signal contrast');
subplot(1,3,3);
plot(10:10:90, contrast31);
title('Grapefruit/Water');xlabel('Flip angle (degrees)'); ylabel('Signal contrast');


%BW SNR

%SNR = mean signal/ stdev background
avg1b = [];
avg2b = [];
avgback = [];
stdevback = [];

load('t1_fl2d_tra_25 flip angle_120bw.mat')
[avg1 std1] = Region(imagedata,160,190,110,140);
[avg2 std2] = Region(imagedata,100,130,20,50);
[avgbackground stdbackground] = Region(imagedata,15,70,70,120);
avg1b(end+1) = avg1;
avg2b(end+1) = avg2;
stdevback(end+1) = stdbackground;
avgback(end+1) = avgbackground;

load('t1_fl2d_tra_25 flip angle_360bw.mat')
[avg1 std1] = Region(imagedata,160,190,110,140);
[avg2 std2] = Region(imagedata,100,130,20,50);
[avgbackground stdbackground] = Region(imagedata,15,70,70,120);
avg1b(end+1) = avg1;
avg2b(end+1) = avg2;
stdevback(end+1) = stdbackground;
avgback(end+1) = avgbackground;

load('t1_fl2d_tra_25 flip angle_850bw.mat')
[avg1 std1] = Region(imagedata,160,190,110,140);
[avg2 std2] = Region(imagedata,100,130,20,50);
[avgbackground stdbackground] = Region(imagedata,15,70,70,120);
avg1b(end+1) = avg1;
avg2b(end+1) = avg2;
stdevback(end+1) = stdbackground;
avgback(end+1) = avgbackground;

SNR1 = (avg1b-avgback)./stdevback;
figure;
subplot(1,2,1);
plot([120 360 850], SNR1);
title('SNR Water');xlabel('Readout bandwith (Hz)'); ylabel('Signal to noise ratio (SNR)');
SNR2 = (avg2b-avgback)./stdevback;
subplot(1,2,2);
plot([120 360 850], SNR2);
title('SNR Oil');xlabel('Readout bandwith (Hz)'); ylabel('Signal to noise ratio (SNR)');




