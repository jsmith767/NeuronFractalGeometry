% patchSpecial(s,N,varargin)
% e.g. patchSpecial(mN,1,'method','LT');
%does a patch for whole neurons, groups, or single branches
%has variable inputs for coloring
%s = masterN struct
%N = neuron number


function patchSpecial(s,N,varargin)

p = inputParser;
addParameter(p, 'curvature',1, @isnumeric); % which of 9 curvatures do we have
addParameter(p, 'singleSeg', false,@islogical); % do you want to look at a single segment? Either do this, 'group' or nothing
addParameter(p, 'single', false,@islogical); % do you want to look at a single branch? Either do this, 'group' or nothing
addParameter(p, 'group', false,@islogical); % do you want to a whole group of a neuron.  Either do this, 'single' or nothing
addParameter(p, 'branchNum',1, @isnumeric); % group and then segment number defined by sla
addParameter(p, 'groupNum',1, @isnumeric); % group and then segment number defined by sla
addParameter(p, 'segNum',1, @isnumeric); % group and then segment number defined by sla
addParameter(p, 'method', 'A',@ischar); % method
addParameter(p, 'hold', false,@islogical); % Holds the figure
addParameter(p, 'figure', false,@islogical); % Creates a new figure window for plotting
addParameter(p, 'faceC',[0.85,0.85,0.85], @isnumeric); %face color for patch
addParameter(p, 'edgeC',[0,0,0], @isnumeric); % edge color for patch
addParameter(p, 'scatter',false ,@islogical); % should a scatter overlay be put on top
addParameter(p, 'scatterC','b' ,@ischar); % scatter color

parse(p,varargin{:});

if p.Results.single
    [V,F]=getVandFsingle(s(N).data.(genvarname(p.Results.method))(p.Results.curvature).VAll,s(N).F,s(N).SLA,p.Results.groupNum,p.Results.branchNum);
elseif p.Results.singleSeg
    [V,F]=getVandFsingleSeg(s(N).data.(genvarname(p.Results.method))(p.Results.curvature).VAll,s(N).F,s(N).SLA,p.Results.groupNum,p.Results.branchNum,p.Results.segNum);
elseif p.Results.group
    V = vertcat(s(N).data.(genvarname(p.Results.method))(p.Results.curvature).VAll{p.Results.groupNum});
    F = vertcat(s(N).F{p.Results.groupNum});
    F = F-min(min(F))+1;
else
    V = vertcat(s(N).data.(genvarname(p.Results.method))(p.Results.curvature).VAll{:});
    F = vertcat(s(N).F{:});
end
if p.Results.figure
    figure
end
set(gcf, 'Color', 'w');
axis equal
axis off
if p.Results.hold
    hold
end
patch('vertices',V,'faces',F(:,1:3),'FaceColor',p.Results.faceC,'EdgeColor',p.Results.edgeC,'FaceAlpha',1);
v1 = [-5 -2 5];
[caz,cel] = view(v1);
if p.Results.scatter
    scatter3(V(:,1),V(:,2),V(:,3),p.Results.scatterC);
end
end