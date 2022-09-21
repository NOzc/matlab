function [x,minf,drawdata] = minPS(f,x0,delta,gama,sita,eps,startIndex_x,endIndex_x,startIndex_y,endIndex_y)
% x0 = char(x0);
% delta=char(delta);
% x0 = str2mat(x0);
% delta=str2mat(delta);
f=char(f);
syms_in_expr=symvar(f);
syms(syms_in_expr)
disp(syms_in_expr)
f=eval(f);
disp(f);
format long;
if nargin == 6
    eps = 1.0e-6;
end
k = 0;
var=[t s];
n = length(var);

while 1
    y = x0;
    yf = Funval(f, var,y);
    for i=1:n
        tmpy = zeros(size(y));
        tmpy(i) = delta(i);
        tmpf = Funval(f, var,y+tmpy);
        if tmpf < yf
            y = y + tmpy;
        else
            tmpf = Funval(f, var,y-tmpy);
            if tmpf < yf
                y = y - tmpy;
            end
        end
    end
    x1 = y;
    fx1 = Funval(f, var,x1);
    if fx1 < yf
        y = x1 + gama*(x1 - x0);
    else
        tol = norm(delta);
        if tol<eps
            x = x0;
            break;
        else
            if x1~=x0
                y = x1;
            else
                y = x1;
                delta = sita*delta;
            end
        end
    end
    x0 = x1;
end
 x = double(x);
 minf = double(Funval(f,var,x));
 drawdata=[];

  for i=startIndex_x:1:endIndex_x
     for j=startIndex_y:1:endIndex_y
         drawdata=[drawdata,[double(i),double(j),double(Funval(f,var,[i j]))]]
     end
 end
 format short;
end