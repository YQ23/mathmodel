% ����������
% population_size: ��Ⱥ��С
% chromosome_size: Ⱦɫ�峤��
% mutate_rate: �������

function mutation(population_size, chromosome_size, mutate_rate)
global population;

for i=1:population_size
    if rand < mutate_rate
        mutate_position = round(rand*chromosome_size);  % ����λ��
        if mutate_position == 0
            % ������λ��Ϊ0��������
            continue;
        end
        population(i,mutate_position) = 1 - population(i, mutate_position);
    end
end

clear i;
clear mutate_position;