%主成分分析
clear;
clc;
close all;
load data.mat %引入data.mat文件
data = data(:,1:3);
[x,mu,sigma] = zscore(data);%标准化处理，将数据减去均值再除以标准差
%数据的标准化处理:得到标准化后的矩阵x
%[a,b]=size(data);3
%for i=1:b
%   x(:,i)=(data(:,i)-mean(data(:,i)))/std(data(:,i));
%end

[coeff,score,latent,tsquare,explained,mu]=pca(x);%用自带函数进行主成分分析
%coeff是各个主成分的系数也就是转换矩阵，score是各个主成分的得分，latent是X的特征值，tsquare是每个数据的统计值

%求特征值贡献率
y = cumsum(latent)./sum(latent);





