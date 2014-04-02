avgr1 = []; avgr2 = []; avgr3 = [];avgr4 = []; avgr5 = []; 
x = [];
sy = 0; sx = 0;
M = [0 0 0 0 0];
for i = 1:6
    matFilename = sprintf(('SpinEcho_T1Weighted_%d.mat'), i);
    load(matFilename);
%     if i == 6
%         M(1)= max(max(imagedata(27:40,55:68)));
%         M(2)= max(max(imagedata(47:60,26:40)));
%         M(3)= max(max(imagedata(68:82,53:40)));
%         M(4)= max(max(imagedata(47:60,26:40)));
%         M(5)= max(max(imagedata(47:60,26:40)));
%     end
    [avg1 std1] = Region(imagedata,27,40,55,68); %water
    [avg2 std2] = Region(imagedata,47,60,26,40); %lowest
    [avg3 std3] = Region(imagedata,68,82,53,68);%middle (53,68) (68,82)
    [avg4 std4] = Region(imagedata,47,60,84,100);%max (84,47) (100,60)
    [avg5 std5] = Region(imagedata,86,97,86,98);%unknown (86,86) (98,97)
    
    figure;
    imagesc(imagedata);
    colormap(gray);
    avgr1(end+1) = avg1;
    avgr2(end+1) = avg2; 
    avgr3(end+1) = avg3; 
    avgr4(end+1) = avg4; 
    avgr5(end+1) = avg5;  
    
    x(end+1) = TR;
    [sy sx] = size(imagedata);
end 

x = x';


y1 = avgr1;
y1 = y1';

y2 = avgr2;
y2 = y2';

y3 = avgr3;
y3 = y3';

y4 = avgr4;
y3 = y3';

y5 = avgr5;
y5 = y5';


waterT1 = -1/-0.0003526;
lowT1 = -1/-0.001168;
midT1 = -1/-0.002061;
highT1 = -1/-0.005097;
unkT1 = -1/-0.003744;

rates = [1/waterT1 1/lowT1 1/midT1 1/highT1]';
concs = [0 .3 .6 1.2]';
figure;
scatter(concs,rates);
xlabel('Gad. concentration(mM)'); 
ylabel('Relaxation rate (1/ms)');
title('Relaxation rate vs. Gad. concentration');
legend('dataset2');
%rate = 0.004465conc -0.00035
%1/unkT1 = 0.004465conc - 0.00035
%(1/unkT1 + .00035)/.004465 = concunknown
concunk= (1/unkT1 + .00035)/.004465;
%concunk = .92





