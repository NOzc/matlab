function [x,minf,drawdata] = minFBNQ(f,a,b,delta,eps,startIndex,endIndex)
    f=char(f);
    syms_in_expr = symvar(f);
    syms(syms_in_expr)
    f = eval(f);
    format long;
    if nargin == 4
        eps = 1.0e-6;
    end

    F = ones(2,1);
    N = (b-a)/eps;
    c = F(2) - N;
    n = 2;

    while c<0
        n = n+1;
        F(n) = F(n-1) + F(n-2);
        c = F(n) - N;
    end

    l = a + F(n-2)*(b-a)/F(n);
    u = a + F(n-1)*(b-a)/F(n);
    k=1;

    while 1
        fl = subs(f, symvar(f), l);
        fu = subs(f, symvar(f), u);
        if fl > fu
            a = l;
            l = u;
            u = a + F(n-k-1)*(b-a)/F(n-k);
            if (k == n - 3)
                break;    
            else
                k = k+1;
            end
        else
            b = u;
            u = l;
            l = a + F(n-k-2)*(b-a)/F(n-k);
            if ( k == n-3 )
                break;    
            else
                k = k+1;
            end
        end
    end
    if k == 100000
        disp('找不到最小值！');
        x = NaN;
        minf = NaN;
        return;
    end
    u = l + delta;
    fl = subs(f, symvar(f), l);
    fu = subs(f, symvar(f), u);
    if fl > fu
        a = l;
    else
        b = l;
    end
    x = (a+b)/2;
    minf = double(subs(f, symvar(f), x));
    drawdata=[];
    for i=startIndex:0.01:endIndex
        drawdata=[drawdata,[double(i),double(subs(f , symvar(f), i))]];
    end
    format short;

