% ������Ⱥ������Ӧ�ȣ��Բ�ͬ���Ż�Ŀ�꣬�޸�����ĺ���
% population_size: ��Ⱥ��С
% chromosome_size: Ⱦɫ�峤��

function fitness(population_size, chromosome_size)
global fitness_value;
global population;

upper_bound = 9;    % �Ա�������������
lower_bound = 0;    % �Ա�������������

% ������Ⱥ������Ӧ�ȳ�ʼ��Ϊ0
for i=1:population_size
    fitness_value(i) = 0.;    
end

% f(x) = -x-10*sin(5*x)-7*cos(4*x);
for i=1:population_size
    for j=1:chromosome_size
        if population(i,j) == 1
            fitness_value(i) = fitness_value(i)+2^(j-1);    % population[i]Ⱦɫ�崮��ʵ�ʵ��Ա���xi�����ƴ�˳�����෴��
        end        
    end
    fitness_value(i) = lower_bound + fitness_value(i)*(upper_bound-lower_bound)/(2^chromosome_size-1);  % �Ա���xi������תʮ����
    fitness_value(i) = fitness_value(i) + 10*sin(5*fitness_value(i)) + 7*cos(4*fitness_value(i));  % �����Ա���xi����Ӧ�Ⱥ���ֵ
end

clear i;
clear j;