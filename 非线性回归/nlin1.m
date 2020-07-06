%[beta,r,J] = nlinfit(x,y,'modelfun',beta0);
%beta �����Ƴ��Ļع�ϵ�� r:�в� J:Jacobian���� x,y ���������� x��y �ֱ�Ϊ����� n ά����������һԪ�����Իع� ,x Ϊ n ά������
%modelfun ��M���������������� inline ����������ķ����Իع麯�� beta0:�ع�ϵ���ĳ�ֵ

%[Y,DELTA]=nlpredci('modelfun', x,beta,r,J) ;
%��ȡ x ����Ԥ��ֵ Y ��Ԥ��ֵ��������Ϊ 1-alpha ���������� Y��DELTA


x=2:16; 
y=[6.42 8.20 9.58 9.5 9.7 10 9.93 9.99 10.49 10.59 10.60 10.80 10.60 10.90 10.76]; 
beta0=[8 2]'; 

[beta,r ,J]=nlinfit(x',y',@modelfun,beta0); 
disp beta1=
disp(beta(1));
disp beta2=
disp(beta(2));

[YY,delta]=nlpredci('modelfun',x',beta,r ,J); 
figure(1);
plot(x,y,'k+',x,YY,'r'); 
xlabel('x');
ylabel('y');
legend('ʵ��ֵ','Ԥ��ֵ');
