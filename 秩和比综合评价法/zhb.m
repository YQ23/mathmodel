clc;
clear;
close all;

load data.txt
%提前将指标都转为正向指标
w = [1/3 1/3 1/3];
R = tiedrank(data);
%对各列分别进行编秩
[n,m] = size(R);
W = repmat(w,n,1);
WPSR = sum(W.*R,2)/n;%计算加权秩和比
freq = tabulate(WPSR);%统计WPSR的频数、频率，freq第三列为频率
p = cumsum(freq(:,3))/100;%计算累积频率
p(end) = p(end) - 1/(4*n);%修正最后一个累积频率
Probit = norminv(p,0,1)+5;%计算标准正态分布的p分位数+5
Probit = [ones(n,1),Probit,Probit.^2,Probit.^3];
[b,bint,r,rint,stats] = regress(WPSR,Probit);%三次多项式回归
b
stats
WPSRfit = Probit .* b;
[s,ind] = sort(WPSRfit,'descend');


