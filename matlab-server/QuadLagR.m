function [xv,fv,drawdata] = QuadLagR(H,c,A,b,startIndex_x,endIndex_x,startIndex_y,endIndex_y)
A=char(A);
c=char(c);
b=char(b);
x0=char(x0);
invH=inv(H);
F =  invH*transpose(A)*inv(A*invH*transpose(A))*A*invH - invH;
D = inv(A*invH*transpose(A))*A*invH;
xv = double(F*c + transpose(D)*b);
fv = double(transpose(xv)*H*xv/2+transpose(c)*xv);
drawdata=[];
for i=startIndex_x:1:endIndex_x
    for j=startIndex_y:1:endIndex_y
        drawdata=[drawdata,[double(i),double(j),double(transpose(xv)*H*xv/2+transpose(c)*xv)]]
    end
end
