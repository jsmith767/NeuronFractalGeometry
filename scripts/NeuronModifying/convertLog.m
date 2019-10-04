%convert to log(1/x)
function y = convertLogx(x,Lnum)
y = log10(Lnum)-x/log(10);
end