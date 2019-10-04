it = 10;
C = cell(it,1);
length0 = 200;
length = length0;

sdp = 0.5;
mu = 0;
sigma = 1;

D = 2.0;
averages = zeros(it,1);
sdGen = zeros(it,1);
setMean = zeros(it,1);
N = zeros(it,1);
for i=1:it
    for j = 1:2^i
        num = normrnd(mu,sigma);
        sd = sdp*length;
        m = length;
        setMean(i) = length;
        lengthG = sd*num + m;
        C{i}(j) = lengthG;
    end
    N(i) = 2^i;
    averages(i) = mean(C{i});
    sdGen(i) = std(C{i});
    length = length/(2^(1/D));
end

% scatter(log(length0./averages),log(N));
% hold
% plot(log(length0./setMean),log(N));
% hold
herrorbar(log(length0./averages),log(N),log(sdGen))
