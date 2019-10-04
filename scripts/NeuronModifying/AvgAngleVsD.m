%Gets angle data for plotting. Doesn't separate the branching angle vs the
%weave angle though.  Just puts them all in one.

function [D,Ang,InitAngs,WeaveAngs,SecondAngs] = AvgAngleVsD(m)
% method = 'original';
% method = 'init';
% method = 'allangles';
% method = 'end';
method = 'W';
% method = 'P';
c = 0:0.25:2;
% c=1;
m(structfind(m,'data',[]))=[];%cleans entries that don't have data
for j=1:length(c)
    D{j} =zeros(length(m),1);
    Ang{j} = cell(length(m),1);
    AveAng{j} = zeros(length(m),1);
    InitAngs{j} = cell(length(m),1);
    WeaveAngsSeg{j} = cell(length(m),1);%Weave angles with which retains the segment info
    WeaveAngs{j} = cell(length(m),1);%Weave angles that bunchess all angles together
    SecondAngs{j} = cell(length(m),1);
end
% j = 5;
% D{ = 
% Ang = cell(length(m),1);
% AveAng = zeros(length(m),1);
for i =1:length(m) %neurons
    for j=5%1:length(c) %curvatures
        D{j}(i) =  m(i).data.(genvarname(method))(j).Ddata.reg.D;
        a = vertcat(m(i).data.(genvarname(method))(j).Angles);
        for k = 1:3
            a = vertcat(a{:});
            if k==1
                InitAngs{j}{i} = zeros(length(a),1);
                SecondAngs{j}{i} = zeros(length(a),1);
                WeaveAngsSeg{j}{i} = cell(length(a),1);
                indRemove = [];
                for p=1:length(a) 
                    InitAngs{j}{i}(p) = a{p}{1};
                    
                    if length(a{p}) ==1 %crude 
                        indRemove = [indRemove p];                                            
                    end
                    if length(a{p}) > 1 %crude fix
                        SecondAngs{j}{i}(p) = a{p}{2};
                    end
                    WeaveAngsSeg{j}{i}{p} = a{p}(3:end);
                end
                SecondAngs{j}{i}(indRemove) = [];
                WeaveAngs{j}{i} = cell2mat(vertcat(WeaveAngsSeg{j}{i}{:}));
            end
        end
        Ang{j}{i} = a;
%         AveAng{j}(i) = mean(a);
    end
end

end