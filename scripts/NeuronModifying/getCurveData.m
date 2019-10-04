function data = getCurveData(curveRange,V,VAll,N,method)
    for j=1:length(curveRange)
        data.(genvarname(method))(j).Curvature = curveRange(j);
        data.(genvarname(method))(j).V = V{j};
        data.(genvarname(method))(j).VAll = VAll{j};
        tempStruct = N{j};
        tempStruct = rmfield(tempStruct,{'name','path','vertices','faces','voxCoords','SLA','voxUnique'});
        tempStruct(end) = [];
        data.(genvarname(method))(j).ItData=tempStruct;
        t = [];
        for i=1:length(tempStruct)
            t = [t;[tempStruct(i).voxUAll]];
        end
        data.(genvarname(method))(j).ptCloud = t;
        data.(genvarname(method))(j).mass = size(data.(genvarname(method))(j).ptCloud,1);
        data.(genvarname(method))(j).W = getAllWidth(VAll{j});
        [~,data.(genvarname(method))(j).volume] = convhull(t);    
    end 
end
%     switch method
%         case 'original'
%             data.original(j).Curvature = curveRange(j);
%             data.original(j).V = V{j};
%             data.original(j).VAll = VAll{j};
%             tempStruct = N{j};
%             tempStruct = rmfield(tempStruct,{'name','path','vertices','faces','voxCoords','SLA','voxUnique'});
%             tempStruct(end) = [];
%             data.original(j).ItData=tempStruct;
%             t = [];
%             for i=1:length(tempStruct)
%                 t = [t;[tempStruct(i).voxUAll]];
%             end
%             data.original(j).ptCloud = t;
%             data.original(j).mass = size(data.original(j).ptCloud,1);
%             data.original(j).W = getAllWidth(VAll{j});
%             [~,data.original(j).volume] = convhull(t);
%                 
%         case 'allangles'
%             data.allangles(j).Curvature = curveRange(j);
%             data.allangles(j).V = V{j};
%             data.allangles(j).VAll = VAll{j};
%             tempStruct = N{j};
%             tempStruct = rmfield(tempStruct,{'name','path','vertices','faces','voxCoords','SLA','voxUnique'});
%             tempStruct(end) = [];
%             data.allangles(j).ItData=tempStruct;
%             t = [];
%             for i=1:length(tempStruct)
%                 t = [t;[tempStruct(i).voxUAll]];
%             end
%             data.allangles(j).ptCloud = t;
%             data.allangles(j).mass = size(data.allangles(j).ptCloud,1);
%             data.allangles(j).W = getAllWidth(VAll{j});
%             [~,data.allangles(j).volume] = convhull(t);
%         case 'end'
%             data.end(j).Curvature = curveRange(j);
%             data.end(j).V = V{j};
%             data.end(j).VAll = VAll{j};
%             tempStruct = N{j};
%             tempStruct = rmfield(tempStruct,{'name','path','vertices','faces','voxCoords','SLA','voxUnique'});
%             tempStruct(end) = [];
%             data.end(j).ItData=tempStruct;
%             t = [];
%             for i=1:length(tempStruct)
%                 t = [t;[tempStruct(i).voxUAll]];
%             end
%             data.end(j).ptCloud = t;
%             data.end(j).mass = size(data.end(j).ptCloud,1);
%             data.end(j).W = getAllWidth(VAll{j});
%             [~,data.end(j).volume] = convhull(t);
%         case 'init'
%             data.init(j).Curvature = curveRange(j);
%             data.init(j).V = V{j};
%             data.init(j).VAll = VAll{j};
%             tempStruct = N{j};
%             tempStruct = rmfield(tempStruct,{'name','path','vertices','faces','voxCoords','SLA','voxUnique'});
%             tempStruct(end) = [];
%             data.init(j).ItData=tempStruct;
%             t = [];
%             for i=1:length(tempStruct)
%                 t = [t;[tempStruct(i).voxUAll]];
%             end
%             data.init(j).ptCloud = t;
%             data.init(j).mass = size(data.init(j).ptCloud,1);
%             data.init(j).W = getAllWidth(VAll{j});
%             [~,data.init(j).volume] = convhull(t);
%     end
% end