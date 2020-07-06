clc;
clear;
close all;

load data.txt
%��ǰ��ָ�궼תΪ����ָ��
w = [1/3 1/3 1/3];
R = tiedrank(data);
%�Ը��зֱ���б���
[n,m] = size(R);
W = repmat(w,n,1);
WPSR = sum(W.*R,2)/n;%�����Ȩ�Ⱥͱ�
freq = tabulate(WPSR);%ͳ��WPSR��Ƶ����Ƶ�ʣ�freq������ΪƵ��
p = cumsum(freq(:,3))/100;%�����ۻ�Ƶ��
p(end) = p(end) - 1/(4*n);%�������һ���ۻ�Ƶ��
Probit = norminv(p,0,1)+5;%�����׼��̬�ֲ���p��λ��+5
Probit = [ones(n,1),Probit,Probit.^2,Probit.^3];
[b,bint,r,rint,stats] = regress(WPSR,Probit);%���ζ���ʽ�ع�
b
stats
WPSRfit = Probit .* b;
[s,ind] = sort(WPSRfit,'descend');


