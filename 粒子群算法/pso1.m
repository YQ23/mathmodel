clear
%%
%define the function

fitness=inline('(2.1*(1-x+2*x.^2).*exp(-x.^2/2))+sin(x)+x','x');

%%
eps=0.001;%��ֹ����
Max_num=50;%����ѭ������
popsize=30;%��Ⱥ����
c1=0.5;%ѧϰ����
c2=1;%ѧϰ����
w=0.3;%��������
vc=0.5;
vmax=0.6;%����ٶ�
x=-5+10*rand(popsize,1);%��ʼ����Ⱥλ��,ά��Ϊ1ά,ͬʱx�ķ�ΧΪ[-5,5]
v=1*rand(popsize,1);%��ʼ���ٶ�
%%
f=fitness(x);%��Ӧ�Ⱥ���
personalbest_x=x;%�����ӵ����λ��
personalbest_f=f;

[groupbest_f, i]=max(personalbest_f);
groupbest_x=x(i);%ȫ������������λ��
gbf = zeros(Max_num,1);%ÿ�ε��������������Ӧ��
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
        x=x+vc*v;%����λ��
     f=fitness(x);%�����Ӧλ�õ���Ӧ��
     for kk=1:popsize
         if f(kk)>personalbest_f(kk)
             personalbest_f(kk)=f(kk);
             personalbest_x(kk)=x(kk);
         end
     end
     [groupbest_f,i]=max(personalbest_f);
     groupbest_x=x(i);
     gbf(j)=groupbest_f;
%      if(groupbest_f>1-eps)%����ﵽ������ֹ������,������
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
legend('������','���Ž�λ��');
subplot(2,1,2)
plot(1:Max_num,gbf,'linewidth',2);
legend('���Ž�ı仯');
xlabel('��������');
ylabel(str);