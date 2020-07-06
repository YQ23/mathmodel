clear
clc
close all
load data.txt
load W.txt
%data�Ǿ��������������,WΪ��ӦȨֵ
A = data;
%output = TOPSIS(data,W);

%function [ output_args ] = TOPSIS(A,W)

%AΪ���߾���WΪȨֵ����,MΪ��ָ�����ڵ��У�NΪ��ָ�����ڵ���
 [ma,na]=size(A);          %maΪA�����������naΪA���������
 gA = zeros(ma,na);
 for i = 1:na
     gA(:,i)=A(:,i)/norm(A(:,i),2); % ԭʼ�����һ�� 
 end
 for i=1:na
     B(:,i)=gA(:,i)*W(i);     %����ѭ���õ�[��Ȩ��׼������]
end
V1=zeros(1,na);            %��ʼ���������͸������
V2=zeros(1,na);
BMAX=max(B);               %ȡ��Ȩ��׼������ÿ�е����ֵ����Сֵ
BMIN=min(B);               %
for i=1:na
     %if i<=size(M,2)        %ѭ���õ������͸�����⣬ע���жϣ���Ȼ�ᳬ����
     V1(i)=BMAX(i);
     V2(i)=BMIN(i);
     %end
     %if i<=size(N,2)
     %V1(N(i))=BMIN(N(i));
     %V2(N(i))=BMAX(N(i));
     %end
end
T = zeros(ma,1);
for i=1:ma                 %����ѭ�����������������
     C1=B(i,:)-V1;
     S1(i)=norm(C1);        %S1,S2�ֱ�Ϊ���������͸������ľ��룬�ö��׷���

     C2=B(i,:)-V2;
     S2(i)=norm(C2);
     T(i)=S2(i)/(S1(i)+S2(i));     %TΪ������
end
output_args=T;
output_args(:,2)=1:ma;
output_args = sortrows(output_args,1,'descend');%��1��Ϊ�������������ȣ����������У���2��Ϊ��Ӧ�ڼ�������
%end
