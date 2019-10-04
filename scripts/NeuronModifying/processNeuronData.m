function slope = processNeuronData(SLA)
% histogram(SLA{1}(:,1),20); % produces a nice histogram plot
SLA = {cat(1, SLA{:})};
[y,x] = hist(SLA{1}(:,1),20); %gets histogram x,y pairs

% plot(x,y);
scatter(log(1./x),log(y)); % has the problem that some bins have zero
% height and thus inf for log(Y).  Need to discuss how best to fit

%clears y of infinities
x = x(y>0);
y = y(y>0);

slope = polyfit(log(1./x),log(y),1); %first element  should be slope
slope = slope(1);

end
