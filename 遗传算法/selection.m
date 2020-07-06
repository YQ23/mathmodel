% ���̶�ѡ�����
% population_size: ��Ⱥ��С
% chromosome_size: Ⱦɫ�峤��
% elitism: �Ƿ�Ӣѡ��

function selection(population_size, chromosome_size, elitism)
global population;      % ǰ����Ⱥ
global population_new;  % ��һ����Ⱥ
global fitness_sum;   % ��Ⱥ������Ӧ��

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
if elitism
    p = population_size-1;
else
    p = population_size;
end

for i=1:p
   for j=1:chromosome_size
       % �����Ӣѡ�񣬽�population��ǰpopulation_size-1��������£����һ�����Ÿ��屣��
       population(i,j) = population_new(i,j);
   end
end

clear i;
clear j;
clear population_new;
clear first;
clear last;
clear idx;
clear mid;