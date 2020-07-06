
clear;
clc;
close all;

load test_data_g  %加载数据
load test_label
load train_data_g
load train_label

%将之前为负一的标签置为0，因为输出函数采用sigmoid
% train_label(train_label==-1) = 0;
% test_label(test_label==-1) = 0;

% W1 = 2*rand(100, 361) - 1;dW1 = zeros(size(W1));
% W2 = 2*rand(50, 100) - 1;dW2 = zeros(size(W2));
% W3 = 2*rand(1, 50) - 1;dW3 = zeros(size(W3));

[m1,n1] = size(train_data_g);%m1个训练样本数,n1个输入参数
[m2,n2] = size(test_data_g);%m2个测试样本数,n2个输入参数,n1=n2

W1 = rand(10,n1);dW1 = zeros(size(W1));%第一层有10个神经元
W2 = rand(5,10);dW2 = zeros(size(W2));%第二层有5个神经元
W3 = rand(1,5);dW3 = zeros(size(W3));%输出为1个参数

tic
BATCH_SIZE=100;%批量为100个样本
EPOCH=1.5e3;%训练1.5万次
accuracy=zeros(1,EPOCH);%准确率
Loss_train=accuracy;Loss_test=accuracy;%训练集损失与测试集损失
lambda =1e-5;%正则项系数
for epoch = 1:EPOCH
   dW1_sum=zeros(size(W1));dW2_sum=zeros(size(W2));dW3_sum=zeros(size(W3));
   dW1=zeros(size(W1));dW2=zeros(size(W2));dW3=zeros(size(W3));
    Loss_sum=0;
    for batch = 1:BATCH_SIZE
        i=round(unifrnd(1,m1));%i为1~m1之间一个均匀分布的随机整数
        X=train_data_g(i,:)';
        D=train_label(i);
        [dW1, dW2, dW3, loss] = Relu_Dropout(W1, W2, W3, X, D, dW1, dW2, dW3);
        dW1_sum=dW1_sum+dW1;dW2_sum=dW2_sum+dW2;dW3_sum=dW3_sum+dW3;
        Loss_sum=Loss_sum+loss;
    end
    W3  = W3 + dW3_sum/BATCH_SIZE - lambda/BATCH_SIZE/2*W3;
    W2  = W2 + dW2_sum/BATCH_SIZE - lambda/BATCH_SIZE/2*W2;
    W1  = W1 + dW1_sum/BATCH_SIZE - lambda/BATCH_SIZE/2*W1;
    Loss_train(epoch)=Loss_sum/BATCH_SIZE;
    %计算准确率和测试集损失
    index=0;
    for k = 1:m2
        x=test_data_g(k,:)';
        d=test_label(k);
        Y = Forward(W1,W2,W3,x);
        Loss_test(epoch)=Loss_test(epoch)+sqrt((d-Y).^2);
        Y = (Y>0.5);%让Y非1即0，阈值为0.5
        if Y~=d
            index=index+1;
        end
    end
    
    rate=1-index/m2;
    if rate>0.95
        break
    end
    accuracy(epoch)=rate;
    Loss_test(epoch)=Loss_test(epoch)/420;
end
toc

subplot(1,3,1)
plot(accuracy(1:epoch),'*')
title('准确率')
xlabel('Epoch')
subplot(1,3,2)
plot(Loss_train(1:epoch),'*')
title('训练集损失')
xlabel('Epoch')
subplot(1,3,3)
plot(Loss_test(1:epoch),'*')
title('测试集损失')
xlabel('Epoch')