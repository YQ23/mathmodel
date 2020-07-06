% 设置遗传算法的参数，测试效果
% 设定求解精度为小数点后4位
elitism = 3;             % 选择精英操作,每次保留3个最优个体
population_size = 50;      % 种群大小
chromosome_size = 20;       % 染色体长度
generation_size = 500;      % 最大迭代次数
cross_rate = 0.8;           % 交叉概率
mutate_rate = 0.01;         % 变异概率
best_fitness = 0;           %初始的适应度为0
best_generation = 1;        %最优解对应的代数,初始化为1
[population] = init(population_size, chromosome_size);% 初始化,产生第一代种群个体
best_individual = population(population_size,:);%初始化最佳个体
fitness_average = zeros(generation_size,1);%初始化平均适应度
for G=1:generation_size   
     % 计算适应度 
    [fitness_value] = fitness(population,population_size, chromosome_size);
    
     % 对个体按适应度大小进行排序
    [fitness_value,population,fitness_sum,fitness_average,best_fitness,best_generation,best_individual]=rank(population_size, chromosome_size,fitness_value,fitness_average,population,best_fitness,best_individual,G,best_generation);
    
     % 选择操作
    [population]=selection(population_size, chromosome_size, elitism,population,fitness_sum);
    
     % 交叉操作
    [population]=crossover(population_size, chromosome_size, cross_rate,population);
  
    % 变异操作
    [population] = mutation(population_size, chromosome_size, mutate_rate,population);
  
end

plotGA(generation_size,fitness_average);% 打印算法迭代过程



% function main()
% elitism = 3;             % 选择精英操作
% population_size = 50;      % 种群大小
% chromosome_size = 30;       % 染色体长度
% generation_size = 500;      % 最大迭代次数
% cross_rate = 0.8;           % 交叉概率
% mutate_rate = 0.01;         % 变异概率
% 
% [best_individual,best_fitness,iterations,x] = genetic_algorithm(population_size, chromosome_size, generation_size, cross_rate, mutate_rate,elitism);
% 
% disp 最优个体:
% best_individual
% disp 最优适应度:
% best_fitness
% disp 最优个体对应自变量值:
% x
% disp 达到最优结果的迭代次数:
% iterations
% 
% end
% % Genetic Algorithm for Functional Maximum Problem
% % f(x) = x+10*sin(5*x)+7*cos(4*x), x∈[0,9]
% 
% % population_size: 输入种群大小
% % chromosome_size: 输入染色体长度
% % generation_size: 输入迭代次数
% % cross_rate: 输入交叉概率
% % mutate_rate: 输入变异概率
% % elitism: 输入精英选择的个数,没有则视为0
% % m: 输出最佳个体
% % n: 输出最佳适应度
% % p: 输出最佳个体出现迭代次数
% % q: 输出最佳个体自变量值
% function [m,n,p,q] = genetic_algorithm(population_size, chromosome_size, generation_size, cross_rate, mutate_rate, elitism)
% 
% global G ;              % 当前迭代次数
% global fitness_value;   % 当前代适应度矩阵
% global best_fitness;    % 历代最佳适应值
% global fitness_average; % 历代平均适应值矩阵
% global best_individual; % 历代最佳个体
% global best_generation; % 最佳个体出现代
% upper_bound = 9;        % 自变量的区间上限
% lower_bound = 0;        % 自变量的区间下限
% 
% fitness_average = zeros(generation_size,1); % 将 generation_size*1 的零矩阵赋给 fitness_average
% 
% disp [ysj genetic algorithm]
% 
% fitness_value(population_size) = 0.;
% best_fitness = 0.;
% best_generation = 0;
% 
% init(population_size, chromosome_size); % 初始化
% 
% for G=1:generation_size   
%     fitness(population_size, chromosome_size);              % 计算适应度 
%     rank(population_size, chromosome_size);                 % 对个体按适应度大小进行排序
%     selection(population_size, chromosome_size, elitism);   % 选择操作
%     crossover(population_size, chromosome_size, cross_rate);% 交叉操作
%     mutation(population_size, chromosome_size, mutate_rate);% 变异操作
% end
% 
% plotGA(generation_size);% 打印算法迭代过程
% 
% m = best_individual;    % 获得最佳个体
% n = best_fitness;       % 获得最佳适应度
% p = best_generation;    % 获得最佳个体出现时的迭代次数
% 
% % 获得最佳个体变量值，对不同的优化目标，这里需要修改
% q = 0.;
% for j=1:chromosome_size
%     if best_individual(j) == 1
%             q = q+2^(j-1);  % 最佳个体变量二进制转十进制
%     end 
% end
% q = lower_bound + q*(upper_bound-lower_bound)/(2^chromosome_size-1); % 解码
% 
% 
% end

% 初始化种群
% population_size: 种群大小
% chromosome_size: 染色体长度

function [population] = init(population_size, chromosome_size)
%global population;
population = zeros(population_size,chromosome_size);
for i=1:population_size
    while((population(i,:)==zeros(chromosome_size,1)))
      for j=1:chromosome_size
        % 给population的i行j列赋值
         population(i,j) = floor(rand*5);  % rand产生(0,1)之间的随机数，round()是四舍五入函数
      end
    end
      
end
end


%计算适应度
function [fitness_value] = fitness(population,population_size, chromosome_size)
    fitness_value = zeros(population_size,1);
%     a1 = zeros(population_size,1);
%     a2 = zeros(population_size,1);
%     a3 = zeros(population_size,1);
    for i = 1:population_size
        fitness_value(i) = sum(population(i,:));
    end
end


% 对个体按适应度大小进行排序，并且保存最佳个体
% population_size: 种群大小
% chromosome_size: 染色体长度
% fitness_sum;      种群累计适应度
% fitness_value;   % 种群适应度
function [fitness_value,population,fitness_sum,fitness_average,best_fitness,best_generation,best_individual]=rank(population_size, chromosome_size,fitness_value,fitness_average,population,best_fitness,best_individual,G,best_generation)
%global 
%global 
%global fitness_average;
%global best_fitness;
%global best_individual;
%global best_generation;
%global population;
%global G;

for i=1:population_size    
    fitness_sum(i) = 0.;
end

% min_index = 1;
% temp = 1;
temp_chromosome(chromosome_size)=0;

% 遍历种群 
% 冒泡排序
% 最后population(i)的适应度随i递增而递增，population(1)最小，population(population_size)最大
for i=1:population_size
    min_index = i;
    for j = i+1:population_size
        if fitness_value(j) < fitness_value(min_index)
            min_index = j;
        end
    end
    
    if min_index ~= i
        % 交换 fitness_value(i) 和 fitness_value(min_index) 的值
        temp = fitness_value(i);
        fitness_value(i) = fitness_value(min_index);
        fitness_value(min_index) = temp;
        % 此时 fitness_value(i) 的适应度在[i,population_size]上最小
        
        % 交换 population(i) 和 population(min_index) 的染色体串
        for k = 1:chromosome_size
            temp_chromosome(k) = population(i,k);
            population(i,k) = population(min_index,k);
            population(min_index,k) = temp_chromosome(k);
        end
    end
end

% fitness_sum(i) = 前i个个体的适应度之和
for i=1:population_size
    if i==1
        fitness_sum(i) = fitness_sum(i) + fitness_value(i);    
    else
        fitness_sum(i) = fitness_sum(i-1) + fitness_value(i);
    end
end

% fitness_average(G) = 第G次迭代个体的平均适应度
fitness_average(G) = fitness_sum(population_size)./population_size;

% 更新最大适应度和对应的迭代次数，保存最佳个体(最佳个体的适应度最大)
if fitness_value(population_size) > best_fitness
    best_fitness = fitness_value(population_size);
    best_generation = G;
    for j=1:chromosome_size
        best_individual(j) = population(population_size,j);
    end
end

end


% 轮盘赌选择操作,精英选择
% population_size: 种群大小
% chromosome_size: 染色体长度
% elitism: 精英选择的个数
% population; 种群
% fitness_sum;   种群积累适应度
function [population]=selection(population_size, chromosome_size, elitism,population,fitness_sum)

population_new = population;
for i=1:population_size
    r = rand * fitness_sum(population_size);  % 生成一个随机数，在[0,总适应度]之间
    first = 1;
    last = population_size;
    mid = round((last+first)/2);
    idx = -1;
    
    % 排中法选择个体
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

   % 产生新一代个体
   for j=1:chromosome_size
        population_new(i,j) = population(idx,j);
   end
end

% 是否精英选择

p = population_size - elitism;


for i=1:p
   for j=1:chromosome_size
       % 如果精英选择，将population中前population_size-elitism个个体更新，最后elitism的最优个体保留
       population(i,j) = population_new(i,j);
   end
end

end


% 单点交叉操作
% population_size: 种群大小
% chromosome_size: 染色体长度
% cross_rate: 交叉概率

function [population]=crossover(population_size, chromosome_size, cross_rate,population)

% 步长为2 遍历种群
for i=1:2:population_size
    % rand<交叉概率，对两个个体的染色体串进行交叉操作
    if(rand < cross_rate)
        y = randperm(chromosome_size);%随机打乱染色体顺序,选取前几个作为交叉的位置
        yi = y(1:(0.4*chromosome_size));
        for j = 1:chromosome_size
            if(any(yi==j))%如果是选择交叉的位置则交换,否则不交换
               temp = population(i,j);
               population(i,j) = population(i+1,j);
               population(i+1,j) = temp;
            end
        end
       
    end
end


end


% 单点变异操作
% population_size: 种群大小
% chromosome_size: 染色体长度
% mutate_rate: 变异概率

function [population] = mutation(population_size, chromosome_size, mutate_rate,population)
%global population;

 for i=1:population_size
    if rand < mutate_rate %如果随机数小于变异率,则进行变异
        y = randperm(chromosome_size);%随机打乱染色体顺序,选取前几个作为交叉的位置
        yi = y(1:(0.8*chromosome_size));%80%的染色体变异
        for j = 1:chromosome_size
            if(any(yi==j))%如果是选择可变异的位置则变异,否则不变异
               ca = [1;2;3;4;5];
               idx = find(ca==(population(i,j)));
               ca(idx) = [];
               idx = ceil(rand*4);
               population(i,j) = ca(idx);%变异操作
            end
        end
        
    end
 end

end

% 打印算法迭代过程
% generation_size: 迭代次数
% fitness_average: 平均适应度
function plotGA(generation_size,fitness_average)
x = 1:1:generation_size;
y = fitness_average;
figure(1);
plot(x,y);
xlabel('迭代次数');
ylabel('平均适应度');
title('种群平均适应度随迭代次数的变化图像');
end