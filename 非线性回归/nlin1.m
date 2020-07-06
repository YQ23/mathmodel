%[beta,r,J] = nlinfit(x,y,'modelfun',beta0);
%beta ：估计出的回归系数 r:残差 J:Jacobian矩阵 x,y ：输入数据 x、y 分别为矩阵和 n 维列向量，对一元非线性回归 ,x 为 n 维列向量
%modelfun ：M函数、匿名函数或 inline 函数，定义的非线性回归函数 beta0:回归系数的初值

%[Y,DELTA]=nlpredci('modelfun', x,beta,r,J) ;
%获取 x 处的预测值 Y 及预测值的显著性为 1-alpha 的置信区间 Y±DELTA


x=2:16; 
y=[6.42 8.20 9.58 9.5 9.7 10 9.93 9.99 10.49 10.59 10.60 10.80 10.60 10.90 10.76]; 
beta0=[8 2]'; 

[beta,r ,J]=nlinfit(x',y',@modelfun,beta0); 
disp beta1=
disp(beta(1));
disp beta2=
disp(beta(2));

[YY,delta]=nlpredci('modelfun',x',beta,r ,J); 
figure(1);
plot(x,y,'k+',x,YY,'r'); 
xlabel('x');
ylabel('y');
legend('实际值','预测值');
