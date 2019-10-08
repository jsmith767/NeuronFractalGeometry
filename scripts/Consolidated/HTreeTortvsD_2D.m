% Model = ImportTxt_2DHTree('D:\Conor\Research\Mathematica\HTree-Models\2D\EndPoints-Txts\It8Branch2D1.10Length5000Theta0Phi0BranchAngle90.001.txt');

Dim = '2';
[Paths, Files] = subdir(fullfile(['D:\Conor\Research\Mathematica\HTree-Models\' Dim 'D']));

its = [10 10 10 10 10 10 10 10 10 12 12 12 12 12 8 8 8 8 8 8 8 8 8 8];
tlen = [76171.7, 93683.1, 112676, 132819, 153801, 175344, 197206, 219184, 241112, 265036, 315527, 368957, 424712, 482225, 45362.8, 53594.4, 62116.6, 70778.4, 79457.9, 88060.4, 96515.1, 104771, 112792, 120556];
Df = [1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 1.6 1.7 1.8 1.9 2.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0];
% numDfs = length(Df);
Nb = 2;
% branchlen = zeros(numDfs,its);
branchlen = zeros(size(Files{1,5},2),max(its));
for f = 1:size(Files{1,5},2)
    for i = 1:its(1,f)
%         branchlen(f,i) = (tlen(1,f)/(sum(Nb.^(((2.*ceil((1:its(1,f))./2)-1).*(Df(1,f)-1)+1)./Df(1,f)))))/(Nb^(((2*ceil(i/2)-1)-1)/Df(1,f))); % For square HTrees
        branchlen(f,i) = (tlen(1,f)/(sum(Nb.^(((1:its(1,f)).*(Df(1,f)-1)+1)./Df(1,f)))))/(Nb^((i-1)/Df(1,f))); % For rectangular HTrees
    end
end

EndPoints = cell(1,size(Files{1,4},2));
for p = 5:5
    masterH = struct();
    for f = 1:size(Files{1,p},2)
        HTree = ImportTxt_2DHTree(fullfile(Paths{1,p}, Files{1,p}{1,f}));
        EndPoints{1,f} = HTree;
        EndPoints{1,f} = EndPoints{1,f}(EndPoints{1,f}(:,1)>0&EndPoints{1,f}(:,2)>0,:);
    end
end

Torts = cell(1,size(Files{1,5},2));
for f = 1:size(Files{1,5},2)
    Torts{1,f} = sum(branchlen(f,branchlen(f,:)~=0))./sqrt((EndPoints{1,f}(:,1)).^2 + (EndPoints{1,f}(:,2)).^2);
end
TortAve = zeros(1,size(Files{1,5},2));
for f = 1:size(Files{1,5},2)
    TortAve(1,f) = mean(Torts{1,f});
end

Dvalue = cell(1,3);
Tortuosity = cell(1,3);
Dvalue{1,1} = Df(1,15:24);
Dvalue{1,2} = Df(1,1:9);
Dvalue{1,3} = Df(1,10:14);
Tortuosity{1,1} = TortAve(1,15:24);
Tortuosity{1,2} = TortAve(1,1:9);
Tortuosity{1,3} = TortAve(1,10:14);

figure;
hold on;
for i = 1:3
    plot(Dvalue{1,i},Tortuosity{1,i})
end

% figure;
% scatter(Df,TortAve,50,'filled')