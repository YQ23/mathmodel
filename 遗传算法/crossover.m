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
        cross_position = round(rand * chromosome_size);
        if (cross_position == 0 || cross_position == 1)
            continue;
        end
        % �� cross_position��֮��Ķ����ƴ����н���
        for j=cross_position:chromosome_size
            temp = population(i,j);
            population(i,j) = population(i+1,j);
            population(i+1,j) = temp;
        end
    end
end


clear i;
clear j;
clear temp;
clear cross_position;