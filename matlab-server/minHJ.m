function [x, minf,drawdata] = minHJ(f,a,b,eps,startIndex,endIndex)
f = char(f);
syms_in_expr = symvar(f);
syms(syms_in_expr)
func = eval(f);
format long;
if nargin == 3
    eps = 1.0e-6;
end

% raw_a = a;
% raw_b = b;
l = a + 0.382*(b-a);
u = a + 0.618*(b-a);
k=1;
tol = b-a;

while tol>eps && k<100000
    fl = subs(func , symvar(func), l);
    fu = subs(func , symvar(func), u);
    if fl > fu
        a = l;
        l = u;
        u = a + 0.618*(b - a);
    else
        b = u;
        u = l;
        l = a + 0.382*(b-a);
    end
    k = k+1;
    tol = abs(b - a);
end
if k == 100000
    disp('找不到最小值！');
    x = NaN;
    minf = NaN;
    return;
end
x = (a+b)/2;
minf = double(subs(func, symvar(func),x));
drawdata=[];
% for i=raw_a:0.1:raw_b
%     drawdata=[drawdata,[double(i),double(subs(func , symvar(func), i))]]
% end
for i=startIndex:0.01:endIndex
    drawdata=[drawdata,[double(i),double(subs(func , symvar(func), i))]]
end
format short;
%fig = figure();
%hold on;
%fplot(f)
%stem(x, minf)
%fig = webfigure(fig);
end
