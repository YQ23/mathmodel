clear%清理无关变量
clc%清除命令行
close all%关闭所有图窗

%第一类数据
mu1=[0 0 0];  %均值
S1=[0.3 0 0;0 0.35 0;0 0 0.3];  %协方差
data1=mvnrnd(mu1,S1,100);   %产生高斯分布数据

%%第二类数据
mu2=[1.25 1.25 1.25];
S2=[0.3 0 0;0 0.35 0;0 0 0.3];
data2=mvnrnd(mu2,S2,100);

%第三个类数据
mu3=[-1.25 1.25 -1.25];
S3=[0.3 0 0;0 0.35 0;0 0 0.3];
data3=mvnrnd(mu3,S3,100);



%显示数据
figure(1);
plot3(data1(:,1),data1(:,2),data1(:,3),'r+');%三维画图
hold on;
plot3(data2(:,1),data2(:,2),data2(:,3),'b+');
plot3(data3(:,1),data3(:,2),data3(:,3),'g+');
grid on;
title('原始数据(已知类别)');
hold off;
%三类数据合成一个不带标号的数据类
data=[data1;data2;data3];   %这里的data是不带标号的

figure(2);
plot3(data(:,1),data(:,2),data(:,3),'black.');
title('原始数据(未分类)');
grid on
hold off;
%k-means聚类
%'sqeuclidean' - 平方欧几里德距离（默认值）
%用于选择初始聚类质心位置的方法 有时被称为“种子”。选择是：'加' - 默认; 
%'Replicates' - 重复聚类的次数，每次都有一个新的初始质心集。正整数，默认为1
[index,center] = kmeans(data,3);

%最后显示聚类后的数据
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
title('K-means聚类之后的结果');

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
