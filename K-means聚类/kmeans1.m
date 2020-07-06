clear%�����޹ر���
clc%���������
close all%�ر�����ͼ��

%��һ������
mu1=[0 0 0];  %��ֵ
S1=[0.3 0 0;0 0.35 0;0 0 0.3];  %Э����
data1=mvnrnd(mu1,S1,100);   %������˹�ֲ�����

%%�ڶ�������
mu2=[1.25 1.25 1.25];
S2=[0.3 0 0;0 0.35 0;0 0 0.3];
data2=mvnrnd(mu2,S2,100);

%������������
mu3=[-1.25 1.25 -1.25];
S3=[0.3 0 0;0 0.35 0;0 0 0.3];
data3=mvnrnd(mu3,S3,100);



%��ʾ����
figure(1);
plot3(data1(:,1),data1(:,2),data1(:,3),'r+');%��ά��ͼ
hold on;
plot3(data2(:,1),data2(:,2),data2(:,3),'b+');
plot3(data3(:,1),data3(:,2),data3(:,3),'g+');
grid on;
title('ԭʼ����(��֪���)');
hold off;
%�������ݺϳ�һ��������ŵ�������
data=[data1;data2;data3];   %�����data�ǲ�����ŵ�

figure(2);
plot3(data(:,1),data(:,2),data(:,3),'black.');
title('ԭʼ����(δ����)');
grid on
hold off;
%k-means����
%'sqeuclidean' - ƽ��ŷ����¾��루Ĭ��ֵ��
%����ѡ���ʼ��������λ�õķ��� ��ʱ����Ϊ�����ӡ���ѡ���ǣ�'��' - Ĭ��; 
%'Replicates' - �ظ�����Ĵ�����ÿ�ζ���һ���µĳ�ʼ���ļ�����������Ĭ��Ϊ1
[index,center] = kmeans(data,3);

%�����ʾ����������
figure(3);

idx1 = find(index==1);
idx2 = find(index==2);
idx3 = find(index==3);
pre_data1 = data(idx1,:); 
pre_data2 = data(idx2,:); 
pre_data3 = data(idx3,:); 
plot3(pre_data1(:,1),pre_data1(:,2),pre_data1(:,3),'r.');
hold on;
plot3(pre_data2(:,1),pre_data2(:,2),pre_data2(:,3),'b.');
plot3(pre_data3(:,1),pre_data3(:,2),pre_data3(:,3),'g.');
grid on
title('K-means����֮��Ľ��');

% idx1 = find(index==1);
% plot3(data(idx1,1),data(idx1,2),data(idx1,3),'r.');
% hold on;
% idx2 = find(index==2);
% plot3(data(idx2,1),data(idx2,2),data(idx2,3),'b.');
% hold on;
% idx3 = find(index==3);
% plot3(data(idx3,1),data(idx3,2),data(idx3,3),'g.');


hold on;
plot3(center(1,1),center(1,2),center(1,3),'yo');
plot3(center(2,1),center(2,2),center(2,3),'mo');
plot3(center(3,1),center(3,2),center(3,3),'co');

grid on
