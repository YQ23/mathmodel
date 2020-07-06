% �����Ŵ��㷨�Ĳ���������Ч��
% �趨��⾫��ΪС�����4λ
clear
elitism = 3;             % ѡ��Ӣ����,ÿ�α���3�����Ÿ���
population_size = 50;      % ��Ⱥ��С
chromosome_size = 20;       % Ⱦɫ�峤��
generation_size = 1000;      % ����������
cross_rate = 0.8;           % �������
mutate_rate = 0.01;         % �������
% best_fitness = 0;           %��ʼ����Ӧ��Ϊ0
% best_generation = 1;        %���Ž��Ӧ�Ĵ���,��ʼ��Ϊ1
[best_individual,best_fitness,best_generation]= genetic_algorithm(population_size, chromosome_size, generation_size, cross_rate, mutate_rate,elitism);
function [m,n,p] = genetic_algorithm(population_size, chromosome_size, generation_size, cross_rate, mutate_rate,elitism)
global G ;              % ��ǰ��������
global fitness_value;   % ��ǰ����Ӧ�Ⱦ���
global best_fitness;    % ���������Ӧֵ
global fitness_average; % ����ƽ����Ӧֵ����
global best_individual; % ������Ѹ���
global best_generation; % ��Ѹ�����ִ�
global population
 init(population_size, chromosome_size);% ��ʼ��,������һ����Ⱥ����
 best_individual = population(population_size,:);%��ʼ����Ѹ���
 fitness_average = zeros(generation_size,1);%��ʼ��ƽ����Ӧ��
  fitness_value = zeros(population_size,1);
  best_fitness = 0;
  best_generation = 1;
for G=1:generation_size   
     % ������Ӧ�� 
     fitness(population_size, chromosome_size);
    
     % �Ը��尴��Ӧ�ȴ�С��������
     rank(population_size, chromosome_size);
    
     % ѡ�����
    selection(population_size, chromosome_size, elitism);
    
     % �������
    crossover(population_size, chromosome_size, cross_rate);
  
    % �������
    mutation(population_size, chromosome_size, mutate_rate);
  
end
m = best_individual;
n = best_fitness;
p = best_generation;
%fprintf('best_individual is %f\n',best_individual);
disp best_individual;
disp(best_individual);
disp best_fitness;
disp(best_fitness);
plotGA(generation_size);% ��ӡ�㷨��������

end


function init(population_size, chromosome_size)
%global population;
global population;
population = zeros(population_size,chromosome_size);
for i=1:population_size
    while((population(i,:)==zeros(chromosome_size,1)))
      for j=1:chromosome_size
        % ��population��i��j�и�ֵ
         population(i,j) = floor(rand*5);  % rand����(0,1)֮����������round()���������뺯��
      end
    end
      
end
end


%������Ӧ��
function fitness(population_size, chromosome_size)
    global population;
    global fitness_value;
   
%     a1 = zeros(population_size,1);
%     a2 = zeros(population_size,1);
%     a3 = zeros(population_size,1);
    for i = 1:population_size
        fitness_value(i) = sum(population(i,:));
    end
end


% �Ը��尴��Ӧ�ȴ�С�������򣬲��ұ�����Ѹ���
% population_size: ��Ⱥ��С
% chromosome_size: Ⱦɫ�峤��
% fitness_sum;      ��Ⱥ�ۼ���Ӧ��
% fitness_value;   % ��Ⱥ��Ӧ��
%[best_fitness,best_individual,best_generation]=  ,best_fitness,best_individual,best_generation
function rank(population_size, chromosome_size)

global fitness_sum;
global fitness_value;
global fitness_average;
global best_fitness;
global best_individual;
global best_generation;
global population;
global G;

for i=1:population_size    
    fitness_sum(i) = 0.;
end

% min_index = 1;
% temp = 1;
temp_chromosome(chromosome_size)=0;

% ������Ⱥ 
% ð������
% ���population(i)����Ӧ����i������������population(1)��С��population(population_size)���
for i=1:population_size
    min_index = i;
    for j = i+1:population_size
        if fitness_value(j) < fitness_value(min_index)
            min_index = j;
        end
    end
    
    if min_index ~= i
        % ���� fitness_value(i) �� fitness_value(min_index) ��ֵ
        temp = fitness_value(i);
        fitness_value(i) = fitness_value(min_index);
        fitness_value(min_index) = temp;
        % ��ʱ fitness_value(i) ����Ӧ����[i,population_size]����С
        
        % ���� population(i) �� population(min_index) ��Ⱦɫ�崮
        for k = 1:chromosome_size
            temp_chromosome(k) = population(i,k);
            population(i,k) = population(min_index,k);
            population(min_index,k) = temp_chromosome(k);
        end
    end
end

% fitness_sum(i) = ǰi���������Ӧ��֮��
for i=1:population_size
    if i==1
        fitness_sum(i) = fitness_sum(i) + fitness_value(i);    
    else
        fitness_sum(i) = fitness_sum(i-1) + fitness_value(i);
    end
end

% fitness_average(G) = ��G�ε��������ƽ����Ӧ��
fitness_average(G) = fitness_sum(population_size)./population_size;

% ���������Ӧ�ȺͶ�Ӧ�ĵ���������������Ѹ���(��Ѹ������Ӧ�����)
if fitness_value(population_size) > best_fitness
    best_fitness = fitness_value(population_size);
    best_generation = G;
    for j=1:chromosome_size
        best_individual(j) = population(population_size,j);
    end
end

end


% ���̶�ѡ�����,��Ӣѡ��
% population_size: ��Ⱥ��С
% chromosome_size: Ⱦɫ�峤��
% elitism: ��Ӣѡ��ĸ���
% population; ��Ⱥ
% fitness_sum;   ��Ⱥ������Ӧ��
function selection(population_size, chromosome_size, elitism)
global population;
global fitness_sum;

population_new = population;
for i=1:population_size
    r = rand * fitness_sum(population_size);  % ����һ�����������[0,����Ӧ��]֮��
    first = 1;
    last = population_size;
    mid = round((last+first)/2);
    idx = -1;
    
    % ���з�ѡ�����
    while (first <= last) && (idx == -1) 
        if r > fitness_sum(mid)
            first = mid;
        elseif r < fitness_sum(mid)
            last = mid;     
        else
            idx = mid;
            break;
        end
        mid = round((last+first)/2);
        if (last - first) == 1
            idx = last;
            break;
        end
    end

   % ������һ������
   for j=1:chromosome_size
        population_new(i,j) = population(idx,j);
   end
end

% �Ƿ�Ӣѡ��

p = population_size - elitism;


for i=1:p
   for j=1:chromosome_size
       % �����Ӣѡ�񣬽�population��ǰpopulation_size-elitism��������£����elitism�����Ÿ��屣��
       population(i,j) = population_new(i,j);
   end
end

end


% ���㽻�����
% population_size: ��Ⱥ��С
% chromosome_size: Ⱦɫ�峤��
% cross_rate: �������

function crossover(population_size, chromosome_size, cross_rate)
global population;
% ����Ϊ2 ������Ⱥ
for i=1:2:population_size
    % rand<������ʣ������������Ⱦɫ�崮���н������
    if(rand < cross_rate)
        y = randperm(chromosome_size);%�������Ⱦɫ��˳��,ѡȡǰ������Ϊ�����λ��
        yi = y(1:(0.4*chromosome_size));
        for j = 1:chromosome_size
            if(any(yi==j))%�����ѡ�񽻲��λ���򽻻�,���򲻽���
               temp = population(i,j);
               population(i,j) = population(i+1,j);
               population(i+1,j) = temp;
            end
        end
       
    end
end


end


% ����������
% population_size: ��Ⱥ��С
% chromosome_size: Ⱦɫ�峤��
% mutate_rate: �������

function mutation(population_size, chromosome_size, mutate_rate)
global population;

 for i=1:population_size
    if rand < mutate_rate %��������С�ڱ�����,����б���
        y = randperm(chromosome_size);%�������Ⱦɫ��˳��,ѡȡǰ������Ϊ�����λ��
        yi = y(1:(0.8*chromosome_size));%80%��Ⱦɫ�����
        for j = 1:chromosome_size
            if(any(yi==j))%�����ѡ��ɱ����λ�������,���򲻱���
               ca = [1;2;3;4;5];
               idx = find(ca==(population(i,j)));
               ca(idx) = [];
               idx = ceil(rand*4);
               population(i,j) = ca(idx);%�������
            end
        end
        
    end
 end

end

% ��ӡ�㷨��������
% generation_size: ��������
% fitness_average: ƽ����Ӧ��
function plotGA(generation_size)
global fitness_average;
x = 1:1:generation_size;
y = fitness_average;
figure(1);
plot(x,y);
xlabel('��������');
ylabel('ƽ����Ӧ��');
title('��Ⱥƽ����Ӧ������������ı仯ͼ��');
end