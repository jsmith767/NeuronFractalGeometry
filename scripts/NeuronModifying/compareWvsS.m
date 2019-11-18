%compare weave vs scaling methods
%load the weave method with 9 curvatures
%load the struct with many scales 'S'

clear w;
clear L;

for i=1:9
wtemp = vertcat(mN(1).masterN(30).data.W(i).W{:});
w(i)=median(wtemp);
end
for i=1:9
L(i) = mN(1).masterN(30).TL;
end
LdW_W = L./w;

[D_S,LdW_S,w_S,L_S] = getLdWVars(mS);
D = [D_W;D_S];
LdW = [LdW_W LdW_S];

figure;scatter(LdW_W,D_W)
hold
Current plot held
scatter(LdW_S,D_S)
legend({'W','S'})
xlabel('Total length/median Width');
ylabel('D');