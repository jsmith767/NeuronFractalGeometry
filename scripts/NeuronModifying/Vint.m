function masterN = Vint(masterN,varargin)
p = inputParser;
addParameter(p,'method','F',@ischar);
addParameter(p,'resolution',0.1,@isnumeric);
addParameter(p,'round',1,@isnumeric); %set the division you want to round to e.g. 2 -> 0.5 4 -> 0.25
parse(p,varargin{:});
method = p.Results.method;
    % method = 'allangles';
%     method = 'W';
    for i=1:length(masterN) %for all the neurons
%         i
    %     [~,~,~,masterN(i).F,~] = analyzeNeuron(masterN(i).path,masterN(i).name);
        for j=1:length(masterN(i).data.(genvarname(method))) % for all the curvatures
            Vinttemp =makeSurface(vertcat(masterN(i).data.(genvarname(method))(j).VAll{:}),vertcat(masterN(i).F{:}),p.Results.resolution);
            masterN(i).data.(genvarname(method))(j).(genvarname(['VintR' num2str(p.Results.round)])) = unique(round(Vinttemp * (p.Results.round)) / (p.Results.round),'rows');
        end
    end
end