
clear;
clc;
close all;

load test_data_g  %��������
load test_label
load train_data_g
load train_label

%��֮ǰΪ��һ�ı�ǩ��Ϊ0����Ϊ�����������sigmoid
% train_label(train_label==-1) = 0;
% test_label(test_label==-1) = 0;

% W1 = 2*rand(100, 361) - 1;dW1 = zeros(size(W1));
% W2 = 2*rand(50, 100) - 1;dW2 = zeros(size(W2));
% W3 = 2*rand(1, 50) - 1;dW3 = zeros(size(W3));

[m1,n1] = size(train_data_g);%m1��ѵ��������,n1���������
[m2,n2] = size(test_data_g);%m2������������,n2���������,n1=n2

W1 = rand(10,n1);dW1 = zeros(size(W1));%��һ����10����Ԫ
W2 = rand(5,10);dW2 = zeros(size(W2));%�ڶ�����5����Ԫ
W3 = rand(1,5);dW3 = zeros(size(W3));%���Ϊ1������

tic
BATCH_SIZE=100;%����Ϊ100������
EPOCH=1.5e3;%ѵ��1.5���
accuracy=zeros(1,EPOCH);%׼ȷ��
Loss_train=accuracy;Loss_test=accuracy;%ѵ������ʧ����Լ���ʧ
lambda =1e-5;%������ϵ��
for epoch = 1:EPOCH
   dW1_sum=zeros(size(W1));dW2_sum=zeros(size(W2));dW3_sum=zeros(size(W3));
   dW1=zeros(size(W1));dW2=zeros(size(W2));dW3=zeros(size(W3));
    Loss_sum=0;
    for batch = 1:BATCH_SIZE
        i=round(unifrnd(1,m1));%iΪ1~m1֮��һ�����ȷֲ����������
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
    %����׼ȷ�ʺͲ��Լ���ʧ
    index=0;
    for k = 1:m2
        x=test_data_g(k,:)';
        d=test_label(k);
        Y = Forward(W1,W2,W3,x);
        Loss_test(epoch)=Loss_test(epoch)+sqrt((d-Y).^2);
        Y = (Y>0.5);%��Y��1��0����ֵΪ0.5
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
title('׼ȷ��')
xlabel('Epoch')
subplot(1,3,2)
plot(Loss_train(1:epoch),'*')
title('ѵ������ʧ')
xlabel('Epoch')
subplot(1,3,3)
plot(Loss_test(1:epoch),'*')
title('���Լ���ʧ')
xlabel('Epoch')