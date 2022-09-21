function [x,minf,drawdata] = minGX(f,x0,x1,eps,startIndex,endIndex)
f=char(f);
syms_in_expr = symvar(f);
syms(syms_in_expr)
f = eval(f);
format long;
if nargin == 3
    eps = 1.0e-6;
end

df = diff(f);
k = 0;
tol = 1;

while tol>eps
    dfx1 = subs(df,symvar(df),x1);
    dfx0 = subs(df,symvar(df),x0);
    x2 = x1 - (x1 - x0)*dfx1/(dfx1 - dfx0);
    k = k + 1;
    tol = abs(dfx1);
    x0 = x1;
    x1 = x2;
end
x = double(x2);
minf =  double(subs(f,symvar(f),x));
drawdata=[];
for i=startIndex:0.01:endIndex
    drawdata=[drawdata,[double(i),double(subs(f , symvar(f), i))]];
end
format short;