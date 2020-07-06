function [dW1,dW2,dW3,loss] = Relu_Dropout(W1, W2, W3, x, D, m1, m2, m3)
alpha = 0.01;
beta = 0.01;

v1 = W1*x;
y1 = max(0,v1);%relu激活
y1 = y1 .* Dropout(y1,0.5);%dropout防止过拟合

v2 = W2*y1;
y2 = max(0,v2);%relu激活
y2 = y2 .* Dropout(y2, 0.5);%dropout防止过拟合

v3 = W3*y2;
%y3 = max(0,v3);
y3 = v3 .* Dropout(v3, 0.5);%dropout防止过拟合

y = 1 ./ (1 + exp(-y3));%sigmoid激活

e = D - y;
loss = sqrt(e.^2);
%loss = abs(D-y);

delta3 = (-1).*y*(1-y)*e;%激活函数sigmoid求导为f'=f(1-f)
e2 = W3'*delta3;

delta2 = (-1).*(v2>0).*e2;%激活函数relu求导
e1 = W2'*delta2;

delta1 = (-1).*(v1>0).*e1;%激活函数relu求导

dW3 = (-1)*alpha*delta3*y2'+ beta*m3;
dW2 = (-1)*alpha*delta2*y1'+ beta*m2;
dW1 = (-1)*alpha*delta1*x' + beta*m1;
end