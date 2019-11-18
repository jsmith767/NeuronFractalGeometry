%e.g. plotReg(masterN(30),'method','S','curvature',1)
% plots the regression with a negative(default) or positive slope
% re-does regression to achieve this.
% optionally just get's the new regression params if you don't want to plot
% only works if you do one masterN at a time.

function reg = plotReg(masterN,varargin) %input a regression struct
p = inputParser;
addParameter(p, 'method','S', @ischar);
addParameter(p, 'curvature',1, @isnumeric);
addParameter(p, 'positiveSlope',false, @islogical);
addParameter(p, 'FSCO',2, @isnumeric);
addParameter(p, 'LSCO',1/5, @isnumeric);
addParameter(p, 'res',4, @isnumeric);
addParameter(p, 'OM',1, @isnumeric);
addParameter(p, 'plot',true,@islogical);
addParameter(p, 'legend',false,@islogical);
addParameter(p, 'Lmax',true,@islogical);
parse(p,varargin{:});
m = matlab.lang.makeValidName(p.Results.method);
c = p.Results.curvature;



for i=1:length(masterN)
    SLA = vertcat(masterN(i).SLA{:});
    Lmax = max(SLA(:,1));
    if ~isfield(masterN(i).data.(m)(c).Ddata,'reg')
        Ddata = masterN(i).data.(m)(c).Ddata;
        l = Ddata.L;
        n = Ddata.N;
        res = Ddata.res;
        masterN(i).data.(m)(c).Ddata.reg = fitwrapperBounds(l,n,res,p.Results.LSCO,p.Results.FSCO,p.Results.OM);
    end
    reg = masterN(i).data.(m)(c).Ddata.reg;
    if p.Results.positiveSlope
%         L10BS = reg.L10BS;
%         L10BScut = reg.L10BScut;
    else
        l = reg.BS;
        n = reg.N;
        res = reg.resolution;
        reg = fitwrapperBoundsPos(l,n,res,p.Results.LSCO,p.Results.FSCO,p.Results.OM);
    end
    if p.Results.plot
        figure
        subplot(2,1,1)
        if p.Results.Lmax
            reg.L10BS = reg.L10BS-log10(Lmax);
            reg.L10BScut = reg.L10BScut-log10(Lmax);
            reg.fit = createFit1(reg.L10BScut,reg.L10Ncut,1,length(reg.L10Ncut));
        end
        scatter(reg.L10BS,reg.L10N,'.')
        hold

        h = plot(reg.fit,'r-',reg.L10BScut,reg.L10Ncut);

        % h2 = plot(reg.fitn,'b--',reg.L10BScutn,reg.L10Ncutn);
        if p.Results.legend
            legend({'Allpts','','D','','Dn'},'Location','NorthWest')
        end
        line([reg.L10BS(reg.LSCOIndn) reg.L10BS(reg.LSCOIndn)], ylim);
        line([reg.L10BS(reg.FSCOIndn) reg.L10BS(reg.FSCOIndn)], ylim);
        % ylim=get(gca,'ylim');
        % xlim=get(gca,'xlim');
        % text(xlim(1),ylim(1),['FSCO =' num2str(reg.FSCOBS) ', LSCO =' num2str(reg.LSCOBS) ', D =' num2str(reg.D)]);
        if ~p.Results.positiveSlope
            if p.Results.Lmax
                xlabel('log10(L/L_{max})');
            else
                xlabel('log10(L)');
            end
        else 
            if p.Results.Lmax
                xlabel('log10(L_{max}/L)');
            else
                xlabel('log10(1/L)');
            end
        end
           
        ylabel('log10(N)');
        title([' min Pts:' num2str(reg.minPtsAllowed) ' FSCO =' num2str(reg.FSCOBS) 'um , LSCO =' num2str(reg.LSCOBS) 'um , D =' num2str(reg.D)]);
        % title(['FSCO =' num2str(reg.FSCOBS) 'um , LSCO =' num2str(reg.LSCOBS) 'um , D =' num2str(reg.D),': FSCOn =' num2str(reg.FSCOBSn) 'um , LSCOn =' num2str(reg.LSCOBSn) 'um , Dn =' num2str(reg.Dn)]);
        hold
        subplot(2,1,2)
        scatter(reg.L10BScut,reg.output.residuals,'o')
        title('Residuals')
        xlabel('log10(L/L_{max})');
    end
end
end