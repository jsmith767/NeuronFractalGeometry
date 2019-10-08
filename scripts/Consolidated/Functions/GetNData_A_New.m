function [D,V,P,BA,M,SA,SAB,VM,R,L,BDbyM,BVbyM,BPbyM,BBAbyM,BMbyM,BSAbyM,BSABbyM,BVMbyM,BRbyM,BLbyM,BFbyM] = GetNData_A_New(plottingN)

    BNumMods = size(plottingN(1).data.A,2);
    Fcell = extractfield(plottingN,'name');
    for i = 1:BNumMods
        for j = 1:size(Fcell,2)
            Fcell{i,j} = Fcell{1,j};
        end
    end
    Dcell = cell(BNumMods,size(plottingN,2));
    Vcell = cell(BNumMods,size(plottingN,2));
    Pcell = cell(BNumMods,size(plottingN,2));
    BAcell = cell(BNumMods,size(plottingN,2));
    Mcell = cell(BNumMods,size(plottingN,2));
    SAcell = cell(BNumMods,size(plottingN,2));
    SABcell = cell(BNumMods,size(plottingN,2));
    VMcell = cell(BNumMods,size(plottingN,2));
    Rcell = cell(BNumMods,size(plottingN,2));
    Lcell = cell(1,size(plottingN,2));
    for c = 1:BNumMods
        for n = 1:size(plottingN,2)
            if ~isempty(plottingN(n).data)
                if ~isempty(plottingN(n).data.A(c).D)
                    Dcell{c,n} = plottingN(n).data.A(c).D;
                    Vcell{c,n} = plottingN(n).data.A(c).volume;
                    Pcell{c,n} = plottingN(n).data.A(c).AveP;
                    BAcell{c,n} = plottingN(n).data.A(c).AveBA;
                    Mcell{c,n} = plottingN(n).data.A(c).mass;
                    SAcell{c,n} = plottingN(n).data.A(c).SA;
                    SABcell{c,n} = plottingN(n).data.A(c).convHullSA;
                    VMcell{c,n} = plottingN(n).data.A(c).mass;
                    Rcell{c,n} = plottingN(n).data.A(c).ArbR;
                end
            end
        end
    end
    for n = 1:size(plottingN,2)
        if ~isempty(plottingN(n).data)
            Lcell{1,n} = plottingN(n).TL;
        end
    end
    IF = ~cellfun(@isempty,Fcell);
    ID = ~cellfun(@isempty,Dcell);
    IV = ~cellfun(@isempty,Vcell);
    IP = ~cellfun(@isempty,Pcell);
    IBA = ~cellfun(@isempty,BAcell);
    IM = ~cellfun(@isempty,Mcell);
    ISA = ~cellfun(@isempty,SAcell);
    ISAB = ~cellfun(@isempty,SABcell);
    IVM = ~cellfun(@isempty,VMcell);
    IR = ~cellfun(@isempty,Rcell);
    Index = and(IF,ID);
    Index = and(Index,IV);
    Index = and(Index,IP);
    Index = and(Index,IBA);
    Index = and(Index,IM);
    Index = and(Index,ISA);
    Index = and(Index,ISAB);
    Index = and(Index,IVM);
    Index = and(Index,IR);
    UseIndex = 1;
    checknum = sum(Index(UseIndex,:));
    for i = 1:BNumMods
        if checknum > sum(Index(i,:))
            checknum = sum(Index(i,:));
            UseIndex = i;
        end
    end
    BFbyM = cell(1,sum(Index(UseIndex,:)));
    BDbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
    D = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
    BVbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
    V = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
    BPbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
    P = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
    BBAbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
    BA = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
    BMbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
    M = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
    BSAbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
    SA = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
    BSABbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
    SAB = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
    BVMbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
    VM = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
    BRbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
    R = zeros((BNumMods)*sum(Index(UseIndex,:)),1);
    BLbyM = zeros(BNumMods,sum(Index(UseIndex,:)));
    L = zeros((BNumMods)*sum(Index(UseIndex,:)),1);

    count = 0;
    for i = 1:BNumMods
        BDbyM(i,:) = vertcat(Dcell{i,Index(UseIndex,:)});
        BVbyM(i,:) = vertcat(Vcell{i,Index(UseIndex,:)});
        BPbyM(i,:) = vertcat(Pcell{i,Index(UseIndex,:)});
        BBAbyM(i,:) = vertcat(BAcell{i,Index(UseIndex,:)});
        BMbyM(i,:) = vertcat(Mcell{i,Index(UseIndex,:)});
        BSAbyM(i,:) = vertcat(SAcell{i,Index(UseIndex,:)});
        BSABbyM(i,:) = vertcat(SABcell{i,Index(UseIndex,:)});
        BVMbyM(i,:) = vertcat(VMcell{i,Index(UseIndex,:)});
        BRbyM(i,:) = vertcat(Rcell{i,Index(UseIndex,:)});
        BLbyM(i,:) = vertcat(Lcell{1,Index(UseIndex,:)});

        jsub = 0;
        if i > 0
            for j = 1:size(plottingN,2)
                if Index(UseIndex,j)
                    count = count + 1;
                    D(count,1) = BDbyM(i,j-jsub);
                    V(count,1) = BVbyM(i,j-jsub);
                    P(count,1) = BPbyM(i,j-jsub);
                    BA(count,1) = BBAbyM(i,j-jsub);
                    M(count,1) = BMbyM(i,j-jsub);
                    L(count,1) = BLbyM(i,j-jsub);
                    SA(count,1) = BSAbyM(i,j-jsub);
                    SAB(count,1) = BSABbyM(i,j-jsub);
                    VM(count,1) = BVMbyM(i,j-jsub);
                    R(count,1) = BRbyM(i,j-jsub);
                else
                    jsub = jsub+1;
                end
            end
        end
    end
    jsub = 0;
    for j = 1:size(plottingN,2)
        if Index(UseIndex,j)
            BFbyM{1,j-jsub} = plottingN(j).name;
        else
            jsub = jsub+1;
        end
    end

end