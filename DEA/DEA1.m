clear;
clc;
close all;

X=[40.4 23.1 33.6 43.2;
    2.45 8.56 5.67 10.03;
    20 70 93 120;
    2500 2000 2500 4000];
Y=[2 3 3 2;
    0.76 0.68 0.83 0.89;
    650 850 800 700];
X = [20,30,40,20,10;
    300,200,100,200,400];
Y = [1000,1000,1000,1000,1000];


X = X';
Y = Y';

% %传统的CCR模型
% [W,Q,T,I] = deacco(X,Y);%Q应该就是θ
% function [W,Q,T,I] = deacco(X,Y)
% X = X';
% Y = Y';
% n = size(X',1);%决策单元个数
% m = size(X,1);%输入指标个数
% s = size(Y,1);%输出指标个数
% A = [-X' Y'];
% b = zeros(n,1);
% LB = zeros(m+s,1);UB = [];
% for i = 1:n
%     Aeq = [X(:,i)' zeros(1,s)];
%     beq = 1;
%     f = [zeros(1,m) -Y(:,i)'];
%     w(:,i) = linprog(f,A,b,Aeq,beq,LB,UB);
%     E(1,i) = Y(:,i)'*w(m+1:m+s,i);
% end
% W = w';
% Q = E;
% [T,I] = sort(E);
% end

%包络DEA模型,看D
[A,B,D] = diccr(X,Y);
function [A,B,D] = diccr(X,Y)
X = X';
Y = Y';
n = size(X',1);%决策单元个数
m = size(X,1);%输入指标个数
s = size(Y,1);%输出指标个数
A = [];
b = [];
LB = zeros(n+m+s+1,1);UB = [];
options = optimset('maxiter',100);
for i = 1:n
    Aeq = [X eye(m) zeros(m,s) -X(:,i)
           Y zeros(s,m) -eye(s) zeros(s,1)];
    beq = [zeros(m,1)
          Y(:,i)];
     f = [zeros(1,n+m+s) 1];
     w(:,i) = linprog(f,A,b,Aeq,beq,LB,UB,[],options);%线性规划
end
A = w(n+1:n+m,:);
B = w(n+m+1:n+m+s,:);
D = w(n+m+s+1,:);
end


% [Q,T,I] = zlcco(X,Y);
% %最劣CCR模型
% function [Q,T,I] = zlcco(X,Y)
% X = X';
% Y = Y';
% n = size(X',1);%决策单元个数
% m = size(X,1);%输入指标个数
% s = size(Y,1);%输出指标个数
% A = [X' -Y'];
% b = zeros(n,1);
% LB = zeros(m+s,1);
% UB = [];
% for i = 1:n
%     Aeq = [X(:,i)' zeros(1,s)];
%     beq = 1;
%     f = [zeros(1,m) Y(:,i)'];
%     w(:,i) = linprog(f,A,b,Aeq,beq,LB,UB);
%     E(1,i) = Y(:,i)' * w(m+1:m+s,i);
% end
% Q = E;
% [T,I] = sort(E);
% end

% [E,T,I] = bcc(X,Y);
% %BCC模型
% function [E,T,I] = bcc(X,Y)
% X = X';
% Y = Y';
% n = size(X',1);%决策单元个数
% m = size(X,1);%输入指标个数
% s = size(Y,1);%输出指标个数
% A = [-X' Y' -ones(n,1)];
% b = zeros(n,1);
% LB = [zeros(m+s,1);[]];
% UB = [];
% for i = 1:n
%     Aeq = [X(:,i)' zeros(1,s+1)];
%     beq = 1;
%     f = [zeros(1,m) -Y(:,i)' 1];
%     w(:,i) = linprog(f,A,b,Aeq,beq,LB,UB);
%     E(1,i) = Y(:,i)' * w(m+1:m+s,i)-w(m+s+1:m+s+1,i);
% end
% [T,I] = sort(E);
% end

% [W,Q,T,I] = deasuper(X,Y);
% %超效率DEA模型
% function [W,Q,T,I] = deasuper(X,Y)
% X = X';
% Y = Y';
% n = size(X',1);%决策单元个数
% m = size(X,1);%输入指标个数
% s = size(Y,1);%输出指标个数
% A = [-X' Y' -ones(n,1)];
% b = zeros(n-1,1);
% LB = zeros(m+s,1);
% UB = [];
% for i = 1:n
%     Aeq = [X(:,i)' zeros(1,s)];
%     beq = 1;
%     f = [zeros(1,m) -Y(:,i)'];
%     if (i==1)
%         A = [-X(:,2:n)' Y(:,2:n)'];
%     elseif i == n
%         A = [-X(:,1:n-1)' Y(:,1:n-1)'];
%   
%     else
%         A = [[-X(:,1:i-1) -X(:,i+1:n)]' [Y(:,1:i-1) Y(:,i+1:n)]'];
%     end
%            
%       w(:,i) = linprog(f,A,b,Aeq,beq,LB,UB);
%       E(1,i) = Y(:,i)' * w(m+1:m+s,i);
%     end
% W = w';
% Q = E;
% [T,I] = sort(E);
% end