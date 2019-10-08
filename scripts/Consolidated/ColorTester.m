% clr = [[1 0 0];[0.72 0.35 0.1];[1 0.55 0];[1 0.9 0];[0 1 0];[0.14 1 0.93];[0 0 1];[0.29 0 0.51];[0.93 0.51 0.93]];
% clr = [[64 12 13];[161 30 34];[197 98 41];[232 166 49];[235 200 152];[191 184 179];[125 162 174];[39 100 120];[0 50 75]]/255;
% clr = [[64 12 13];[161 30 34];[197 98 41];[191 184 179];[125 162 174];[39 100 120];[0 50 75]]/255;
% clr = [[64 12 13];[161 30 34];[197 60 41];[220 200 200];[255 255 255];[200 200 220];[125 162 174];[39 100 120];[0 50 75]]/255;
% clr = [[175 200 255];[100 143 255];[120 94 240];[170 66 183.5];[220 38 127];[237 67.5 63.5];[254 97 0];[255 176 0];[255 255 0]]/255;
% clr = [[255 0 0];[255 120 0];[255 255 0];[0 0 255];[0 200 0];[127 0 128]]/255;
clr = [[200 0 0];[255 255 255];[0 0 200]]/255;
interpdiv = 9;
interpclr = zeros(size(clr,1)+((interpdiv-1)*(size(clr,1)-1)),3);
for i = 1:size(clr,1)-1
    for j = 1:interpdiv
        interpclr((i-1)*interpdiv+j,:) = clr(i,:) + ((clr(i+1,:)-clr(i,:))./interpdiv)*(j-1);
    end
end
interpclr(end,:) = clr(end,:);

NumDots = 500;
RDots = zeros(length(interpclr),NumDots,2);
for i = 1:length(interpclr)
    for j = 1:NumDots
        RDots(i,j,:) = [rand rand];
    end
end

clrline(1:size(interpclr,1), 1:2) = 1.05;
clrline(1:size(interpclr,1), 1) = 0.05:(0.95-0.05)/(size(interpclr,1)-1):0.95;

figure
hold;
%ClrStr = ["Red" "Brown" "Orange" "Yellow" "Green" "Turqoise" "Blue" "Purple" "Pink"];
for i = 1:length(interpclr)
    scatter(RDots(i,:,1), RDots(i,:,2), '.', 'MarkerFaceColor', interpclr(i,:), 'MarkerEdgeColor', interpclr(i,:))
    scatter(clrline(i,1),clrline(i,2), 30, 'MarkerFaceColor', interpclr(i,:), 'MarkerEdgeColor', interpclr(i,:))
end
%legend(ClrStr)
title('Randomized Colored Dots')
xlim([0 1])
ylim([0 1.1])
set(gca,'DataAspectRatio',[1 1 1])