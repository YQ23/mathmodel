%加载数据
%load xdata;
%load ydata;
clear

xdata = zeros(10,3);
xdata(:,1) = 1:10;
xdata(:,2) = 1:10;
xdata(:,3) = 15:24;
ydata = zeros(10,1);
ydata(:,1) = 14 + 6*xdata(:,2) + 10*log(sqrt(xdata(:,3))+1) + 2*rand(10,1);


%优化参数设置
t = optimget(optimset('lsqcurvefit'),'MaxFunEvals');
optimset('MaxFunEvals',2000);%最大迭代次数2000
x0 = rand(3,1);%有3个变量

%曲线拟合
coef1 = lsqcurvefit(@fun1,x0,xdata,ydata);
ynew = coef1(1) + coef1(2)*xdata(:,2) + coef1(3)*log(sqrt(xdata(:,3))+1);
figure(2);
plot(1:length(ydata),ydata,'-o',1:length(ydata),ynew,'-*');
legend('实际值','预测值');
figure(3);
h1 = histogram(ydata-ynew);%histogram画直方图
h1.Normalization = 'probability';
std1 = norm(ynew-ydata,2)^2/length(ydata);
disp(std1);
[h,p] = lillietest(ydata-ynew);%lillietest检验是否正态分布,h=0,p>0.05服从正态分布
%chi2gof(卡方拟合)、jbtest(Jarque-Bera检验)、kstest(K-S检验)和lillietest(正态)
disp(h);

function y = fun1(coef,xdata)
    count = size(xdata,1);
    y = zeros(count,1);
    for i = 1:count
        y(i) = coef(1) + coef(2).*xdata(i,2) + coef(3).*log(sqrt(xdata(i,3))+1);
    end
end