N = 1;
% numpoints = zeros(1,size(masterN(N).data.allangles(5).VAll,2));
numpoints = zeros(1,size(masterN(N).data.W(5).VAll,2));
% for b = 1:size(masterN(N).data.allangles(5).VAll,2)
for b = 1:size(masterN(N).data.W(5).VAll,2)
%     numpoints(1,b) = numpoints(1,b) + size(masterN(N).data.allangles(5).VAll{1,b},1);
    numpoints(1,b) = numpoints(1,b) + size(masterN(N).data.W(5).VAll{1,b},1);
end
X = zeros(sum(numpoints),1);
Y = zeros(sum(numpoints),1);
Z = zeros(sum(numpoints),1);
count = 0;
% for b = 1:size(masterN(N).data.allangles(5).VAll,2)
for b = 1:size(masterN(N).data.W(5).VAll,2)
%     X(count+1:count+numpoints(1,b),1) = masterN(N).data.allangles(5).VAll{1,b}(:,1);
%     Y(count+1:count+numpoints(1,b),1) = masterN(N).data.allangles(5).VAll{1,b}(:,2);
%     Z(count+1:count+numpoints(1,b),1) = masterN(N).data.allangles(5).VAll{1,b}(:,3);
    X(count+1:count+numpoints(1,b),1) = masterN(N).data.W(5).VAll{1,b}(:,1);
    Y(count+1:count+numpoints(1,b),1) = masterN(N).data.W(5).VAll{1,b}(:,2);
    Z(count+1:count+numpoints(1,b),1) = masterN(N).data.W(5).VAll{1,b}(:,3);
    count = count + numpoints(1,b);
end
figure;
subplot(1,2,1)
scatter3(X,Y,Z,'k.')
subplot(1,2,2)
% scatter3(masterN(N).data.allangles(5).ptCloud(:,1),masterN(N).data.allangles(5).ptCloud(:,2),masterN(N).data.allangles(5).ptCloud(:,3),'k.')
scatter3(masterN(N).data.W(5).ptCloud(:,1),masterN(N).data.W(5).ptCloud(:,2),masterN(N).data.W(5).ptCloud(:,3),'k.')
figure;
subplot(1,2,1)
scatter3(X,Y,Z,'k.')
subplot(1,2,2)
% scatter3(plottingN(N).data.allangles(5).VintR1(:,1),plottingN(N).data.allangles(5).VintR1(:,2),plottingN(N).data.allangles(5).VintR1(:,3),'k.')
scatter3(plottingN(N).data.W(5).VintR1(:,1),plottingN(N).data.W(5).VintR1(:,2),plottingN(N).data.W(5).VintR1(:,3),'k.')