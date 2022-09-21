function [x,minf,drawdata] = minNewton(f,x0,eps,startIndex,endIndex)
f=char(f);
syms_in_expr = symvar(f);
syms(syms_in_expr)
f = eval(f);
format long;
if nargin == 2
    eps = 1.0e-6;
end

df = diff(f);
d2f = diff(df);
k = 0;
tol = 1;

while tol>eps
    dfx = subs(df,symvar(df),x0);
    if diff(d2f) == 0
        d2fx = double(d2f);
    else
        d2fx = subs(d2f,symvar(d2f),x0); 
    end
    x1 = x0 - dfx/d2fx;
    k = k + 1;
    tol = abs(dfx);
    x0 = x1;
end

x = double(x1);
minf =  double(subs(f,symvar(f),x));
drawdata=[];
for i=startIndex:0.01:endIndex
    drawdata=[drawdata,[double(i),double(subs(f , symvar(f), i))]];
end
format short;