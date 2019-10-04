%figure3
function y = figure3(struct1,struct2)
    figure
    
    try
        D = extractfield(struct1,'D');
        Dm = mean(cell2mat(vertcat(D{:})),2);
        Dstd = std(cell2mat(vertcat(D{:}))')';
    catch
    %     Gets around issues where we have holes in D
        for i=1:length(struct1)
            k=1;
            for j=1:length(struct1(i).D)
                try
                    Ds{i}(k) = struct1(i).D{j};
                    k = k+1;
                catch
                    %disp('skipped');
                end
            end
            Dm(i) = mean(Ds{i});
            Dstd(i) = std(Ds{i});
        end
    end
    

    nP = extractfield(struct1,'nP');
    Pstd = std(cell2mat(vertcat(nP{:}))')';
    Pm = mean(cell2mat(vertcat(nP{:})),2);
    C = 0:5:200;
%     C(5) = [];
    subplot(2,1,1)
    yyaxis left
    errorbar(C,Pm,Pstd,'-o')
%     ylim([0.82 1.22])
    ylabel('\sigma');
    yyaxis right
    errorbar(C,Dm,Dstd,'-o')
    ylim([1.1 2.4]);
    ylabel('D');
    set(gca, 'XTickLabel', [])
    ntitle('a)','location','southeast'); 
    title('Curvature vs D & \sigma');

    try
        D = extractfield(struct2,'D');
        Dm = mean(cell2mat(vertcat(D{:})),2);
        Dstd = std(cell2mat(vertcat(D{:}))')';
    catch
    %     Gets around issues where we have holes in D
        for i=1:length(struct2)
            k=1;
            for j=1:length(struct2(i).D)
                try
                    Ds2{i}(k) = struct2(i).D{j};
                    k = k+1;
                catch
                    %disp('skipped');
                end
            end
            Dm(i) = mean(Ds2{i});
            Dstd(i) = std(Ds2{i});
        end
    end
    nP = extractfield(struct2,'nP');
    Pstd = std(cell2mat(vertcat(nP{:}))')';
    Pm = mean(cell2mat(vertcat(nP{:})),2);
    C = 0:5:200;
%     C(5) = [];
    subplot(2,1,2)
    yyaxis left
    errorbar(C,Pm,Pstd,'-o')
%     ylim([0.82 1.22])
    ylabel('\sigma');
    yyaxis right
    errorbar(C,Dm,Dstd,'-o')
    ylim([1.1 2.4]);
    ylabel('D');
    xlabel('Curvature');
    ntitle('b)','location','southeast'); 
%     title('Same Volume');
end


