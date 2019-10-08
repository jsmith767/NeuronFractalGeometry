numpoints = 500;
poismeans = [1 3 5 7 9 11];
poisdists = cell(1,5);
for i = 1:6
    poisdists{1,i} = poissrnd(poismeans(1,i),[1,numpoints]);
end

gausmeans = [1 3 5 7 9 11];
gausdevs = [0.5 1.5 2.5 3.5 4.5 5.5];
gausdists = cell(1,5);
for i = 1:6
    gausdists{1,i} = normrnd(gausmeans(1,i),gausdevs(1,i),[1,numpoints]);
end

figure;
bar(poisdists{1,1});


% figure;
% for i = 1:3
%     for j = 1:2
%         subplot(2,5,(j-1)*5+i)
%         histogram(poisdists{1,(j-1)*3+i});
%     end
% end
% subplot(2,5,[4,5,9,10])
% boxplot(cell2mat(poisdists')','Notch','on')