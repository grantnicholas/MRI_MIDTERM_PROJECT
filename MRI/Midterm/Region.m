%Grant Nicholas

function [avg,stdev] = region(newimage,y1,y2,x1,x2) 
%region1 = [];
%for j= y1:y2
   % for i = x1:x2
     %  region1(end+1) = abs(newimage(j,i));
    %end
%end
%avg = mean(region1);
%stdev = std(region1);

avg = mean2(newimage(y1:y2,x1:x2));
stdev = std2(newimage(y1:y2,x1:x2));
end

