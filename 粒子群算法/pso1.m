clear
%%
%define the function

fitness=inline('(2.1*(1-x+2*x.^2).*exp(-x.^2/2))+sin(x)+x','x');

%%
eps=0.001;%终止条件
Max_num=50;%设置循环次数
popsize=30;%种群数量
c1=0.5;%学习因子
c2=1;%学习因子
w=0.3;%惯性因子
vc=0.5;
vmax=0.6;%最大速度
x=-5+10*rand(popsize,1);%初始化种群位置,维度为1维,同时x的范围为[-5,5]
v=1*rand(popsize,1);%初始化速度
%%
f=fitness(x);%适应度函数
personalbest_x=x;%各粒子的最佳位置
personalbest_f=f;

[groupbest_f, i]=max(personalbest_f);
groupbest_x=x(i);%全局最佳粒子最佳位置
gbf = zeros(Max_num,1);%每次迭代的最佳粒子适应度
for j=1:Max_num
       v=w*v+c1*rand*(personalbest_x-x)+c2*rand*(groupbest_x*ones(popsize,1)-x);
        for kk=1:popsize
              if v(kk)>vmax
                     v(kk)=vmax;
              else if(v(kk)<-vmax)
                      v(kk)=-vmax;
                  end
              end
        end
        x=x+vc*v;%更新位置
     f=fitness(x);%计算对应位置的适应度
     for kk=1:popsize
         if f(kk)>personalbest_f(kk)
             personalbest_f(kk)=f(kk);
             personalbest_x(kk)=x(kk);
         end
     end
     [groupbest_f,i]=max(personalbest_f);
     groupbest_x=x(i);
     gbf(j)=groupbest_f;
%      if(groupbest_f>1-eps)%如果达到可以终止的条件,则跳出
%          break;
%      end
end
   str=num2str(groupbest_f)
   %%
subplot(2,1,1)
  x_0=-5:0.01:5;
  f_0=fitness(x_0);
plot(x_0,f_0,'r','linewidth',2);
hold on
plot(groupbest_x,groupbest_f,'b+','linewidth',6);
legend('所求函数','最优解位置');
subplot(2,1,2)
plot(1:Max_num,gbf,'linewidth',2);
legend('最优解的变化');
xlabel('迭代次数');
ylabel(str);