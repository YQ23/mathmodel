%����SVM����ѵ��
clear
clc
close all 
%����ѵ������
load train_data.txt  
load train_label.txt
load test_data.txt
load test_label.txt
%���й�һ������
train_data1 = norm_column(train_data);
test_data1 = norm_column(test_data);

%����SVM���������ѵ��
SVMModel_rbf = fitcsvm(train_data1,train_label,'KernelFunction','rbf','OptimizeHyperparameters',{'BoxConstraint','KernelScale'},  'HyperparameterOptimizationOptions',struct('ShowPlots',false));
%ʹ��ѵ���õĵ�ģ�ͽ��в���
[predict_label,score] = predict(SVMModel_rbf,test_data1);
error = predict_label - test_label;
error(error~=0)=1;
[m,~]=size(test_label);
%����׼ȷ��
accuracy = 1 - sum(error)./m;

%����ѵ���������Լ���Ԥ�����ͼ
label1 = find(train_label==1);
label2 = find(train_label==-1);
label3 = find(test_label==1);
label4 = find(test_label==-1);
label5 = find(predict_label==1);
label6 = find(predict_label==-1);
figure(1);
plot(train_data(label1,1),train_data(label1,2),'ro');
hold on;
plot(train_data(label2,1),train_data(label2,2),'go');
title('ѵ�����ֲ�');
legend('1','-1');
figure(2);
plot(test_data(label3,1),test_data(label3,2),'ro');
hold on;
plot(test_data(label4,1),test_data(label4,2),'go');
title('���Լ��ֲ�');
legend('1','-1');
figure(3);
plot(test_data(label5,1),test_data(label5,2),'ro');
hold on;
plot(test_data(label6,1),test_data(label6,2),'go');
title('���Լ�Ԥ��ֲ�');
legend('1','-1');

%���й�һ������
function newdat = norm_column(dataMat)
len = size(dataMat,1);
maxV = max(dataMat);
minV = min(dataMat);
range = maxV - minV;
newdat = (dataMat-repmat(minV,[len,1]))./(repmat(range,[len,1]));
end