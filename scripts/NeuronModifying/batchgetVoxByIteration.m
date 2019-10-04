% f = cell(8,1);
% f{1} = '000';
% f{2} = '025';
% f{3} = '050';
% f{4} = '075';
% % f{5} = '100';
% f{5} = '125';
% f{6} = '150';
% f{7} = '175';
% f{8} = '200';
c = 5;%curvature
s = BDataEnd;
mainD = pwd;
% for j=1:length(f)
%     cd(f{j})
    parfor i=1:length(s(c).name)
        try
        i
        N = getVoxByIteration(s,i,c);
        masterN(i).name = s(c).name{i};
        masterN(i).data = N;
        catch

        end
    end
    save('masterN.mat', 'masterN', '-v7.3')
	cd(mainD)
% end