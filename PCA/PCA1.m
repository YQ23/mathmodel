%���ɷַ���
clear;
clc;
close all;
load data.mat %����data.mat�ļ�
data = data(:,1:3);
[x,mu,sigma] = zscore(data);%��׼�����������ݼ�ȥ��ֵ�ٳ��Ա�׼��
%���ݵı�׼������:�õ���׼����ľ���x
%[a,b]=size(data);3
%for i=1:b
%   x(:,i)=(data(:,i)-mean(data(:,i)))/std(data(:,i));
%end

[coeff,score,latent,tsquare,explained,mu]=pca(x);%���Դ������������ɷַ���
%coeff�Ǹ������ɷֵ�ϵ��Ҳ����ת������score�Ǹ������ɷֵĵ÷֣�latent��X������ֵ��tsquare��ÿ�����ݵ�ͳ��ֵ

%������ֵ������
y = cumsum(latent)./sum(latent);





