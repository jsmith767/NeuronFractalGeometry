%convert to log(1/x)
function y = convertLogx(x,Lnum)
y = Lnum/log(10)-x/log(10);
end