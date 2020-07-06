%主成分分析范例
clear 
% data=[3,3,1,7.8,12.1,0.175,815,29,1.10,0.61;
%       2,2,3,5.5,9.8,0.126,620,23,1.42,0.96;
%       1,1,4,4.2,10.6,0.147,437,17,1.08,1.07;
%       4,1,1,10.5,14.9,0.238,916,32,1.02,0.29;
%       2,1,3,6.5,11.8,0.169,583,20,1.30,0.79;
%       3,2,2,8.3,13.5,0.181,836,28,1.16,0.85;
%       2,3,2,9.1,10.3,0.145,714,25,1.11,0.72];
%A=[1.2,1400,12,121,0.02;1.23,1500,10,100,0.023;1.1,1000,13,111,0.012;1.4,2930,9,102,0.04];
 data = xlsread('data1.xlsx','sheet1','A2:I10');
%得到的数据矩阵的行数和列数
a=size(data,1);
b=size(data,2);

%数据的标准化处理:得到标准化后的矩阵SA
[SA,mu,sigma] = zscore(data);
% for i=1:b
%     SA(:,i)=(data(:,i)-mean(data(:,i)))/std(data(:,i));
% end
xlswrite('data2.xlsx',SA,'sheet1','B3');
%计算系数矩阵:CM
CM=corrcoef(SA);
xlswrite('data2.xlsx',CM,'sheet1','B16');
%计算CM的特征值和特征向量
[V,D]=eig(CM);
%将特征值按降序排列到DS中
for j=1:b
    DS(j,1)=D(b+1-j,b+1-j);
end
%计算贡献率
for i=1:b
    DS(i,2)=DS(i,1)/sum(DS(:,1));%单个贡献率
    DS(i,3)=sum(DS(1:i,1))/sum(DS(:,1));%累计贡献率
end
xlswrite('data2.xlsx',DS,'sheet1','L3');
%假定主成分的信息保留率为95%
T=0.95;
for k=1:b
    if DS(k,3) >= T
        com_num=k;
        break;
    end
end
%提取主成分的特征向量
for j=1:com_num
    PV(:,j)=V(:,b+1-j);
end
xlswrite('data2.xlsx',PV','sheet1','B28');
%计算主成分得分
new_score=SA*PV;
for i=1:a
    total_score(i,1)=sum(new_score(i,:));
    total_score(i,2)=i;
end
%强主成分得分与总分放到同一个矩阵中
result_report=[new_score,total_score];
%按总分降序排列
result_report=sortrows(result_report,-4);
%输出结果
disp('特征值、贡献率、累计贡献率：')
DS
disp('信息保留率T对应的主成分数与特征向量：')
com_num
PV
disp('主成分得分及排序（按第4列的总分进行降序排列，前3列为各成分得分，第5列为编号）')
result_report