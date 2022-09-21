function [x,minf] = minTri(f,a,b,eps)
f=char(f);
syms_in_expr = symvar(f);
disp(syms_in_expr)
syms(syms_in_expr)
f = eval(f);
format long;
if nargin == 3
    eps = 1.0e-6;
end

df = diff(f);
t0 = (a+b)/2;
k = 0;
tol = 1;

while tol>eps
    fa = subs(f,symvar(f),a);
    fb = subs(f,symvar(f),b);
    dfa = subs(df,symvar(df),a);
    dfb = subs(df,symvar(df),b);

    w = 3*(fb - fa)/(b-a) - dfa - dfb;
    z = sqrt(w^2 - dfa*dfb);
    t1 = a + (z - dfa - w)*(b-a)/(2*z - dfa + dfb);
       
    dft1 = subs(df,symvar(df),t1);
    tol = abs(dft1);
    if dft1 < 0
        a = t1;
    else
        b = t1;
    end
    k = k+1;
    t0 = t1;
end

x = t1;
minf =  subs(f,symvar(f),x);
format short;


