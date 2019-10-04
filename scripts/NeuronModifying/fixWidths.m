for i=1:length(masterN)
    s = load([masterN(i).name '.mat']);
for j = 1:length(masterN(i).data.original)
s.x.data.original(j).W = getAllWidth(s.x.data.original(j).VAll);
end
s.x = rmfield( s.x , 'W' );
x = s.x;
save([masterN(i).name '.mat'],'x');
end