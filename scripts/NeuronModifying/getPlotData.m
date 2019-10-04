function [D,P,L,M,VM,SA,SAt,V,CA,BL] = getPlotData(s,varargin)
    p = inputParser;
    addParameter(p, 'method','allangles', @ischar);
    addParameter(p, 'curves', 1:9, @isnumeric);
    parse(p,varargin{:});
    method = p.Results.method;
    C = p.Results.curves;
    
    D = zeros(length(s)*length(C),1);
    P = zeros(length(s)*length(C),1);
%     PM = zeros(length(s)*length(C),1);
    L = zeros(length(s)*length(C),1);
    M = zeros(length(s)*length(C),1);
    VM = zeros(length(s)*length(C),1);
    SA = zeros(length(s)*length(C),1);
    SAt = zeros(length(s)*length(C),1);
    V = zeros(length(s)*length(C),1);
    CA = zeros(length(s)*length(C),1);
    BL = zeros(length(s)*length(C),1);
%     W = zeros(length(s)*length(C),1);
    
    I = 1;
    for i=1:length(s)
        for j=C
            try
                D(I) = s(i).data.(genvarname(method))(j).Ddata.reg.D;
            catch
                warning('No D data');
            end
            try
                P(I) = s(i).data.(genvarname(method))(j).AveP;
            catch
                warning('No P data');
            end
%             try
%                 PM(I) = max(s(i).data.(genvarname(method))(j).AllP);
%             catch
%                 warning('No PM data');
%             end
            try
                L(I) = s(i).TL;
            catch
                warning('No L data');
            end
            try
                M(I) = s(i).data.(genvarname(method))(j).mass;
            catch
                warning('No M data');
            end
            try
                VM(I) = s(i).data.(genvarname(method))(j).volMass;
            catch
                warning('No volMass data');
            end            
            try
                SA(I) = s(i).data.(genvarname(method))(j).SA;
            catch
                warning('No SA data');
            end
            try
                SAt(I) = s(i).data.(genvarname(method))(j).SAt;
            catch
                warning('No SAt data');
            end
            try
                V(I) = s(i).data.(genvarname(method))(j).volume;
            catch
                warning('No V data');
            end
            try
                CA(I) = s(i).data.(genvarname(method))(j).convHullSA;
            catch
                warning('No convHullSurfaceArea data');
            end
            try
                BLtemp = vertcat(s(i).SLA{:});
                BL(I) = mean(BLtemp(:,1));
            catch
                warning('No SLA data');
            end
                I = I+1;
        end
    end
end