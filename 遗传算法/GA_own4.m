clear
%max f(x) = 2x1+3x2+x3 + 3x1^2+x2^2
%s.t.
%x1+2x1^2+x2+2x2^2+x3<=10
%x1+x1^2+x2+x2^2-x3<=50
%2x1+x1^2+2x2+x3<=40
%x1^2+x3=2
%x1+2x2>=1
%x1>=0,x2,x3不约束

A = [-1,-2,0;-1,0,0];%-x1-2x2<=-1,-x1<=0
b = [-1;0];
[x,y] = ga(@ycfun1,3,A,b,[],[],[],[],@ycfun2);
x,y=-y

%适应度函数
function y = ycfun1(x)%x为行向量
c1 = [2,3,1];c2 = [3,1,0];%max f(x) = 2x1+3x2+x3 + 3x1^2+x2^2
y = c1 * x' + c2 * x' .^2;
y = -y;%将max转化为min
end

%非线性约束函数
function [f,g] = ycfun2(x)
    f = [x(1)+2*x(1)^2+x(2)+2*x(2)^2+x(3)-10;%x1+2x1^2+x2+2x2^2+x3<=10
        x(1)+x(1)^2+x(2)+x(2)^2-x(3)-50;%x1+x1^2+x2+x2^2-x3<=50
        2*x(1)+x(1)^2+2*x(2)+x(3)-40];%2x1+x1^2+2x2+x3<=40
    g = x(1)^2 + x(3) - 2;%x1^2+x3=2
end