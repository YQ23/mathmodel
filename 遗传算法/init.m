% ��ʼ����Ⱥ
% population_size: ��Ⱥ��С
% chromosome_size: Ⱦɫ�峤��

function init(population_size, chromosome_size)
global population;
for i=1:population_size
    for j=1:chromosome_size
        % ��population��i��j�и�ֵ
        population(i,j) = round(rand);  % rand����(0,1)֮����������round()���������뺯��
    end
end
clear i;
clear j;