%figure3
function y = figure3A(struct1)
    figure
    Dm = extractfield(struct1,'mD');
    Dstd = extractfield(struct1,'stdD');
    
    Pm = extractfield(struct1,'mnPvM');
    Pstd = extractfield(struct1,'stdnPvM');
    C = 0:5:200;

    yyaxis left
    errorbar(C,Pm,Pstd,'-o')
%     ylim([0.82 1.22])
    ylabel('\sigma');
    yyaxis right
    errorbar(C,Dm,Dstd,'-o')
%     ylim([1.32 1.63]);
    ylabel('D');
%     set(gca, 'XTickLabel', [])
%     ntitle('a)','location','southeast'); 
%     title('Same Mass');
% 
%     try
%         D = extractfield(struct2,'D');
%         Dm = mean(cell2mat(vertcat(D{:})),2);
%         Dstd = std(cell2mat(vertcat(D{:}))')';
%     catch
%     %     Gets around issues where we have holes in D
%         for i=1:length(struct2)
%             k=1;
%             for j=1:length(struct2(i).D)
%                 try
%                     Ds2{i}(k) = struct2(i).D{j};
%                     k = k+1;
%                 catch
%                     %disp('skipped');
%                 end
%             end
%             Dm(i) = mean(Ds2{i});
%             Dstd(i) = std(Ds2{i});
%         end
%     end
%     nP = extractfield(struct2,'nP');
%     Pstd = std(cell2mat(vertcat(nP{:}))')';
%     Pm = mean(cell2mat(vertcat(nP{:})),2);
%     C = 0:25:200;
% %     C(5) = [];
%     subplot(2,1,2)
%     yyaxis left
%     errorbar(C,Pm,Pstd,'-o')
%     ylim([0.82 1.22])
%     ylabel('\sigma');
%     yyaxis right
%     errorbar(C,Dm,Dstd,'-o')
%     ylim([1.32 1.63]);
%     ylabel('D');
%     xlabel('Curvature');
%     ntitle('b)','location','southeast'); 
% %     title('Same Volume');
end


