clear                                          %��ջ����еı���
load data1.txt                                 %������е�����
t0 = clock;                                    %�����ʱ��ʼ
%%
%%%%%%%%%%%%%%%%%%%��ʼ��%%%%%%%%%%%%%%%%%
city=data1;
n = size(city,1);                               %���о����ʼ��
D = zeros(n,n);                                                   
for i = 1:n
    for j = 1:n
           if i ~= j
            D(i,j) = sqrt(sum((city(i,:) - city(j,:)).^2));
        else
            D(i,j) = 0;      %�趨�ĶԽǾ�������ֵ
        end
    end   
end
m=30;                                               %��������
alpha = 1;                                          % ��Ϣ����Ҫ�̶�����
beta = 5;                                           % ����������Ҫ�̶�����
v = 0.1;                                            % ��Ϣ�ػӷ�����
Q = 0.5;                                            % ��Ϣ���ӳ�ϵ��
H= 1./D;                                            % ��������
T= ones(n,n);                                       % ��Ϣ�ؾ���
Table = zeros(m,n);                                 % ·����¼��
iter = 1;                                           % ����������ֵ
iter_max = 50;                                      % ����������
best_route = zeros(iter_max,n);                     % �������·��      
best_length = zeros(iter_max,1);                    % �������·���ĳ��� 
%%
while iter<=iter_max
    
                        % �������ÿֻ���ϵ�������
                          start = zeros(m,1);
                          for i = 1:m
                              temp = randperm(n);
                              start(i) = temp(1);
                          end
                          Table(:,1) = start;
                          city_index=1:n;
                          for i = 1:m
                          % �������·��ѡ��
                          for j = 2:n
                             tabu = Table(i,1:(j - 1));                            % �ѷ��ʵĳ��м���
                             allow =city_index( ~ismember(city_index,tabu));    % ɸѡ��δ���ʵĳ��м���
                             P = zeros(1,length(allow));
                             % �����������е�ת�Ƹ���
                             for k = 1:length(allow)
                                 P(k) = T(tabu(end),allow(k))^alpha * H(tabu(end),allow(k))^beta;
                             end
                             P = P/sum(P);
                             % ���̶ķ�ѡ����һ�����ʳ���
                            Pc = cumsum(P);     %�μ�˵��2(����ײ�)
                            target_index = find(Pc >= rand);
                            target = allow(target_index(1));
                            Table(i,j) = target;
                         end
                      end
 
                          % ����������ϵ�·������
                                  Length = zeros(m,1);
                                  for i = 1:m
                                      Route = [Table(i,:) Table(i,1)];
                                      for j = 1:n
                                          Length(i) = Length(i) + D(Route(j),Route(j + 1));
                                      end
                                  end  
             %������·�ߺ;������           
                   if iter == 1
                      [min_length,min_index] = min(Length);
                      best_length(iter) = min_length; 
                      best_route(iter,:) = Table(min_index,:);
                  else
                      [min_length,min_index] = min(Length);
                           if min_length<best_length(iter-1)
                                     best_length(iter)=min_length;
                                     best_route(iter,:)=Table(min_index,:);
                           else
                                    best_length(iter)=best_length(iter-1);
                                    best_route(iter,:)=best_route(iter-1,:);
                           end
                   end
                            % ������Ϣ��
                          Delta_T= zeros(n,n);
                          % ������ϼ���
                          for i = 1:m
                              % ������м���
                              Route = [Table(i,:) Table(i,1)];
                              for j = 1:n
                                  Delta_T(Route(j),Route(j+1)) = Delta_T(Route(j),Route(j+1)) +D(Route(j),Route(j+1))* Q/Length(i);
                              end
                          end
                          T= (1-v) * T + Delta_T;
                          % ����������1�������·����¼��
                        iter = iter + 1;
                        Table = zeros(m,n);             
end
%--------------------------------------------------------------------------
%% �����ʾ
shortest_route=best_route(end,:);                 %ѡ����̵�·���еĵ�
short_length=best_length(end);
Time_Cost=etime(clock,t0);
disp(['��̾���:' num2str(short_length)]);
disp(['���·��:' num2str([shortest_route shortest_route(1)])]);
disp(['����ִ��ʱ��:' num2str(Time_Cost) '��']);
%--------------------------------------------------------------------------
%% ��ͼ
figure(1)
%��������ͼ������
plot([city(shortest_route,1);city(shortest_route(1),1)], [city(shortest_route,2);city(shortest_route(1),2)],'o-');
for i = 1:size(city,1)
    %��ÿ�����н��б��
    text(city(i,1),city(i,2),['   ' num2str(i)]);
end
xlabel('����λ�ú�����')
ylabel('����λ��������')
title(['��Ⱥ�㷨���Ż�·��(��̾��룩:' num2str(short_length) ''])
 
figure(2)
%������������
plot(1:iter_max,best_length,'b')
xlabel('��������')
ylabel('����')
title('������������')