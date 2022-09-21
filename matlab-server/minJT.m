function [minx,minf, maxx,maxf,drawdata] = minJT(f, x0, h0, eps,startIndex,endIndex)
f=char(f);
syms_in_expr = symvar(f);
syms(syms_in_expr)
f = eval(f);
format long;
if nargin == 3
    eps = 1.0e-6;
end

x1 = x0;
k = 0;
h = h0;
while 1
    x4 = x1 + h;
    k = k+1;
    f4 = subs(f, symvar(f), x4);
    f1 = subs(f, symvar(f), x1);
    if f4 < f1
        x2 = x1;
        x1 = x4;
        f2 = f1;
        f1 = f4;
        h = 2*h;
    else
        if k==1
            h = -h;
            x2 = x4;
            f2 = f4;
        else
            x3 = x2;
            x2 = x1;
            x1 = x4;
            break;
        end
    end
end

minx = min(x1,x3);
minf = double(subs(f, symvar(f),minx));
maxx = x1+x3 - minx;
maxf = double(subs(f, symvar(f),maxx));
drawdata=[];
for i=startIndex:0.01:endIndex
    drawdata=[drawdata,[double(i),double(subs(f , symvar(f), i))]];
end
format short;

