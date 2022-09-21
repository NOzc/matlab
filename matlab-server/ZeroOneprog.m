function [intx,intf,drawdata] = ZeroOneprog(c,A,b,x0,startIndex_x,endIndex_x,startIndex_y,endIndex_y)
% A=char(A);
% c=char(c);
% b=char(b);
% x0=char(x0);
sz = size(A);
if sz(2) < 3
    [intx,intf] = Allprog(c,A,b);
else
    [intx,intf] = Explicitprog(c,A,b,x0);
end

function [intx,intf] = Allprog(c,A,b);
sz_A = size(A);
rw = sz_A(1);
col = sz_A(2);

minf = inf;
for i=0:(2^(col)-1)
    x1 = myDec2Bin(i,col);
    if A*x1 >= b
        f_tmp = c*x1;
        if f_tmp < minf
            minf = f_tmp;
            intx = x1;
            intf = minf;
        else
            continue;
        end
    else
        continue;
    end      
end
end
function [intx,intf] = Explicitprog(c,A,b,x0)
sz_A = size(A);
rw = sz_A(1);
col = sz_A(2);

minf =c*[x0];
A = [A;-c];
b = [b;-minf];
for i=0:(2^(col)-1)
    x1 = myDec2Bin(i,col);
    if A*x1 >= b
        f_tmp = c*x1;
        if f_tmp < minf
            minf = f_tmp;
            b(rw+1,1) = -minf;
            intx = x1;
            intf = minf;
            
         else
            continue;
        end
    else
        continue;
    end      
end
end
function y = myDec2Bin(x,n)
str = dec2bin(x,n);
for j=1:n
    y(j) = str2num(str(j));
end
y = transpose(y);
 end

drawdata=[];
for i=startIndex_x:1:endIndex_x
    for j=startIndex_y:1:endIndex_y
        drawdata=[drawdata,[double(i),double(j),intf]]
    end
end
end
