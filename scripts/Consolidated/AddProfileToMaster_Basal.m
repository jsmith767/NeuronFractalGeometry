load('K:\Keck\Programs\masterN\MatlabBoxCountingMethod\masterNOM1_2-oneFifth_P.mat');

viewpoints = 200; %Number of viewpoints to use when calculating the profile area
ExpandDiameterBy = 0; %Number of voxels to expand the diameter of the neurons by
NumNeurs = size(masterN,2);

for n = 1:NumNeurs
    if isempty(masterN(n).data)
        continue
    end
    NumCurvs = size(masterN(n).data.P,2);
    for c = 1:NumCurvs
        [p,plist,pit,pilist,latlonlist] = ProfileAreaByIteration(masterN(n).data.P(c).ItData,viewpoints,ExpandDiameterBy+1);
        masterN(n).data.P(c).AveP = p;
        masterN(n).data.P(c).AllP = plist;
        masterN(n).data.P(c).LatLon = latlonlist;
        for i = 1:size(masterN(n).data.P(c).ItData,2)
            masterN(n).data.P(c).ItData(i).AveP = pit(i,1);
            masterN(n).data.P(c).ItData(i).AllP = pilist(i,:);
        end
%         [p,plist,pit,pilist,latlonlist] = ProfileAreaByIteration_New(masterN(n).data.W(c).ItData,viewpoints,ExpandDiameterBy+1);
%         masterN(n).data.W(c).AveP = p;
%         masterN(n).data.W(c).AllP = plist;
%         masterN(n).data.W(c).LatLon = latlonlist;
%         for i = 1:size(masterN(n).data.W(c).ItData,2)
%             masterN(n).data.W(c).ItData(i).AveP = pit(i,1);
%             masterN(n).data.W(c).ItData(i).AllP = pilist(i,:);
%         end
%         [p,plist,pit,pilist,latlonlist] = ProfileAreaByIteration_New(masterN(n).data.I(c).ItData,viewpoints,ExpandDiameterBy+1);
%         masterN(n).data.I(c).AveP = p;
%         masterN(n).data.I(c).AllP = plist;
%         masterN(n).data.I(c).LatLon = latlonlist;
%         for i = 1:size(masterN(n).data.I(c).ItData,2)
%             masterN(n).data.I(c).ItData(i).AveP = pit(i,1);
%             masterN(n).data.I(c).ItData(i).AllP = pilist(i,:);
%         end
%         [p,plist,pit,pilist,latlonlist] = ProfileAreaByIteration_New(masterN(n).data.original(c).ItData,viewpoints,ExpandDiameterBy+1);
%         masterN(n).data.original(c).AveP = p;
%         masterN(n).data.original(c).AllP = plist;
%         masterN(n).data.original(c).LatLon = latlonlist;
%         for i = 1:size(masterN(n).data.original(c).ItData,2)
%             masterN(n).data.original(c).ItData(i).AveP = pit(i,1);
%             masterN(n).data.original(c).ItData(i).AllP = pilist(i,:);
%         end
%         [p,plist,pit,pilist,latlonlist] = ProfileAreaByIteration_New(masterN(n).data.init(c).ItData,viewpoints,ExpandDiameterBy+1);
%         masterN(n).data.init(c).AveP = p;
%         masterN(n).data.init(c).AllP = plist;
%         masterN(n).data.init(c).LatLon = latlonlist;
%         for i = 1:size(masterN(n).data.init(c).ItData,2)
%             masterN(n).data.init(c).ItData(i).AveP = pit(i,1);
%             masterN(n).data.init(c).ItData(i).AllP = pilist(i,:);
%         end
%         [p,plist,pit,pilist,latlonlist] = ProfileAreaByIteration_New(masterN(n).data.allangles(c).ItData,viewpoints,ExpandDiameterBy+1);
%         masterN(n).data.allangles(c).AveP = p;
%         masterN(n).data.allangles(c).AllP = plist;
%         masterN(n).data.allangles(c).LatLon = latlonlist;
%         for i = 1:size(masterN(n).data.allangles(c).ItData,2)
%             masterN(n).data.allangles(c).ItData(i).AveP = pit(i,1);
%             masterN(n).data.allangles(c).ItData(i).AllP = pilist(i,:);
%         end
    end
end

% for n = 1:NumNeurs
%     if isempty(masterN(n).data)
%         continue
%     end
%     NumCurvs = size(masterN(n).data.original,2);
%     for c = 1:NumCurvs
%         masterNB(n).data.original(c).AveP = masterN(n).data.original(c).AveP;
%         masterNB(n).data.original(c).AllP = masterN(n).data.original(c).AllP;
%         masterNB(n).data.original(c).LatLon = masterN(n).data.original(c).LatLon;
%         for i = 1:size(masterNB(n).data.original(c).ItData,2)
%             masterNB(n).data.original(c).ItData(i).AveP = masterN(n).data.original(c).ItData(i).AveP;
%             masterNB(n).data.original(c).ItData(i).AllP = masterN(n).data.original(c).ItData(i).AllP;
%         end
%     end
% end

save('K:\Keck\Programs\masterN\masterNOM1_2-oneFifth_56_P_Prof.mat','masterN','-v7.3');
clear('masterN')