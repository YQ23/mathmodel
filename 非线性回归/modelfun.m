function yhat=modelfun(beta,x) 
%beta ����Ҫ�ع�Ĳ���
%x���ṩ������
yhat=beta(1)*exp(beta(2)./x); 
end