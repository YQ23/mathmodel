function B=fce(A,R,type)
%ʵ��ģ���ϳ����ӵļ���
%AΪ���ؼ������ص�Ȩ������,RΪ���о���,Ҫ��A����������R������
%typeѡ��ģ���ϳ����ӵ�����, 1-5�ֱ��Ӧǰ�ĵ�5�ֲ�ͬ����
%B�����ۺ����н��
[n,m]=size(R);  
B=zeros(1,m);
for j=1:m
    switch type
        case 1       %ȡСȡ�������ؾ�����
            B(j)=max(min([A;R(:,j)']));               
        case 2       %�˻����������ͻ����
            B(j)=max([A.*R(:,j)']);  
        case 3       %�˼ӣ���Ȩƽ����
            B(j)=sum(A.*R(:,j)');    
        case 4        %ȡС�Ͻ����
            B(j)=min(1,sum(min([A;R(:,j)'])));
        case 5        %����ƽ����
            r0=sum(R(:,j));
            B(j)=sum(min([A;R(:,j)'./r0]));
    end         
end
B=B./sum(B);  %��һ��
end

%�����������Ⱥ���,y=trimf(x,[a b c])
%���������Ⱥ���,p=[a,b,c,d],y=trapmf(x, [a b c d])
%��˹�����Ⱥ���,y=gaussmf(x,[sig c])

%���������/���������Ⱥ���(�ݼ�) , p=[a,b]
function y = dtrimf(x,p)
y = zeros(size(x));
y(x<=p(1)) = 1;
I = x>p(1) & x<p(2);
y(I) = (p(2)-x(I))/(p(2)-p(1));
end



%�Ҷ�������/���������Ⱥ���(����) , p=[a,b]
function y = itrimf(x,p)
y = zeros(size(x));
y(x>=p(2)) = 1;
I = x>p(1) & x<p(2);
y(I) = (x(I)-p(1))/(p(2)-p(1));
end

%��˸�˹�����Ⱥ���(�ݼ�), p=[a,sigma]
function y = dgaussmf(x,p)
y = ones(size(x));
I = x > p(1);
y(I) = exp(-((x(I)-p(1))/p(2)).^2);
end

%�Ҷ˸�˹�����Ⱥ���(����), p=[a,sigma]
function y = igaussmf(x,p)
y = ones(size(x));
I = x < p(1);
y(I) = exp(-((x(I)-p(1))/p(2)).^2);
end

function R = EvalMatrix(x)
r1 = [dtrimf(x(1),[350 450]), trapmf(x(1), [250 350 450 550]), ...
        trapmf(x(1), [350 450 550 650]), itrimf(x(1), [450 550 700 700])];
r2 = [itrimf(x(2), [3.5 4]), trimf(x(2), [2.5 3 3.5]), ...
        trimf(x(2), [1.5 2 2.5]), dtrimf(x(2), [1 1.5])];
r3 = [itrimf(x(3),[40,60]), trapmf(x(3),[20:20:80]), ...
        trapmf(x(3), [0:20:60]), dtrimf(x(3),[20,40])];
r4 = [dtrimf(x(4), [50 90]), trapmf(x(4), [0 50 90 130]), ...
       trapmf(x(4), 50:40:170), itrimf(x(4), [90 130])];
r5 = [itrimf(x(5), [3.5 4]), trimf(x(5), [2.5 3 3.5]), ...
        trimf(x(5), [1.5 2 2.5]), dtrimf(x(5), [1 1.5])];
R = [r1; r2; r3; r4; r5];


x1 = [592.5 3 55  72 4];
x2 = [529   2 38 105 3];
x3 = [412   1 32  85 2];
R1 = EvalMatrix(x1);
R2 = EvalMatrix(x2);
R3 = EvalMatrix(x3);
A=[0.2 0.1 0.15 0.3 0.25];
type=3;  %ѡ���3��ģ���ϳ�����M(.,+)
B1=fce(A,R1,type)
B2=fce(A,R2,type)
B3=fce(A,R3,type)
w = 0:3;
s1 = B1*w'
s2 = B2*w'
s3 = B3*w'
end