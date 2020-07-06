function yhat=modelfun(beta,x) 
%beta 是需要回归的参数
%x是提供的数据
yhat=beta(1)*exp(beta(2)./x); 
end