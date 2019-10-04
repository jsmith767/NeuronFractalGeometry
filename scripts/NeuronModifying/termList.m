TL = PL;
count = 1;
for i=length(t):-1:1
    TL(TL(:,1)==t(i),2)=count;
    count = count+1;
end