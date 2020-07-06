

clear;
clc;
close all;

 
%% test Data
%数据下载网站：http://archive.ics.uci.edu/ml/machine-learning-databases/iris/
%这里使用的iris数据的一部分，由于第3维和第4为数据数据区分度好，因此用3、4维数据测试
X1 =[5.1,3.5,1.4,0.2;%,Iris-setosa
4.9,3.0,1.4,0.2;
4.7,3.2,1.3,0.2;
4.6,3.1,1.5,0.2;
5.1,3.7,1.5,0.4;
4.6,3.6,1.0,0.2;
5.1,3.3,1.7,0.5;
5.0,3.6,1.4,0.2;
5.4,3.9,1.7,0.4;
4.6,3.4,1.4,0.3;
5.0,3.4,1.5,0.2;
4.4,2.9,1.4,0.2;
4.9,3.1,1.5,0.1;
5.4,3.7,1.5,0.2;
4.8,3.4,1.6,0.2;
4.8,3.0,1.4,0.1;
4.3,3.0,1.1,0.1;
5.8,4.0,1.2,0.2;
5.7,4.4,1.5,0.4;
5.4,3.9,1.3,0.4;
5.1,3.5,1.4,0.3;
5.7,3.8,1.7,0.3;
5.1,3.8,1.5,0.3;
5.4,3.4,1.7,0.2;
6.4,3.2,4.5,1.5;%Iris-versicolor
6.9,3.1,4.9,1.5;
5.5,2.3,4.0,1.3;
6.5,2.8,4.6,1.5;
5.7,2.8,4.5,1.3;
6.3,3.3,4.7,1.6;
4.9,2.4,3.3,1.0;
4.9,2.4,3.3,1.0;
6.6,2.9,4.6,1.3;
5.2,2.7,3.9,1.4;
5.0,2.0,3.5,1.0;
5.9,3.0,4.2,1.5;
6.0,2.2,4.0,1.0];
 
X=X1(:,3:4);
 
%%KNN k distance graph, to determine the epsilon
%根据k距离图大致确定0.15为较适合的Eps参数值
A=X;
numData=size(A,1);
Kdist=zeros(numData,1);
[IDX,Dist]=knnsearch(A(2:numData,:),A(1,:));
Kdist(1)=Dist;
for i=2:size(A,1)
    [IDX,Dist] = knnsearch(A([1:i-1,i+1:numData],:),A(i,:));
    Kdist(i)=Dist;
end
[sortKdist,sortKdistIdx]=sort(Kdist,'descend');
distX=[1:numData]';
plot(distX,sortKdist,'r+-','LineWidth',2);
title('K distance graph');
set(gcf,'position',[1000 340 350 350]);
grid on;
 
%% Run DBSCAN Clustering Algorithm
epsilon= 0.15 ;
MinPts=  3   ;
IDX1=DBSCAN(X,epsilon,MinPts);
%% Plot Results
figure;
PlotClusterinResult(X, IDX1);
title(['DBSCAN Clustering (\epsilon = ' num2str(epsilon) ', MinPts = ' num2str(MinPts) ')']);
set(gcf,'position',[30 -10 500 500]); 
 
 
epsilon= 0.25 ;
MinPts=  3   ;
IDX2=DBSCAN(X,epsilon,MinPts);
%% Plot Results
figure;
PlotClusterinResult(X, IDX2);
title(['DBSCAN Clustering (\epsilon = ' num2str(epsilon) ', MinPts = ' num2str(MinPts) ')']);
set(gcf,'position',[530 -10 500 500]);
 
epsilon= 0.5 ;
MinPts=  3   ;
IDX3=DBSCAN(X,epsilon,MinPts);
%% Plot Results
figure;
PlotClusterinResult(X, IDX3);
title(['DBSCAN Clustering (\epsilon = ' num2str(epsilon) ', MinPts = ' num2str(MinPts) ')']);
set(gcf,'position',[30 380 500 500]);
 
 
%DBSCAN算法子函数
function [IDX, isnoise]=DBSCAN(X,epsilon,MinPts)
    C=0;
    n=size(X,1);
    IDX=zeros(n,1);
    D=pdist2(X,X);
    visited=false(n,1);
    isnoise=false(n,1);
    for i=1:n
        if ~visited(i)
            visited(i)=true;
            
            Neighbors=RegionQuery(i);
            if numel(Neighbors)<MinPts
                % X(i,:) is NOISE
                isnoise(i)=true;
            else
                C=C+1;
                ExpandCluster(i,Neighbors,C);
            end
            
        end
    end
    
    function ExpandCluster(i,Neighbors,C)
        IDX(i)=C;
        
        k = 1;
        while true
            j = Neighbors(k);
            
            if ~visited(j)
                visited(j)=true;
                Neighbors2=RegionQuery(j);
                if numel(Neighbors2)>=MinPts
                    Neighbors=[Neighbors Neighbors2];   %#ok
                end
            end
            if IDX(j)==0
                IDX(j)=C;
            end
            
            k = k + 1;
            if k > numel(Neighbors)
                break;
            end
        end
    end
    
    function Neighbors=RegionQuery(i)
        Neighbors=find(D(i,:)<=epsilon);
    end
 
end
 
%结果显示子函数
function PlotClusterinResult(X, IDX)
 
    k=max(IDX);
 
    Colors=hsv(k);
 
    Legends = {};
    for i=0:k
        Xi=X(IDX==i,:);
        if i~=0
            Style = 'x';
            MarkerSize = 8;
            Color = Colors(i,:);
            Legends{end+1} = ['Cluster #' num2str(i)];
        else
            Style = 'o';
            MarkerSize = 6;
            Color = [0 0 0];
            if ~isempty(Xi)
                Legends{end+1} = 'Noise';
            end
        end
        if ~isempty(Xi)
            plot(Xi(:,1),Xi(:,2),Style,'MarkerSize',MarkerSize,'Color',Color);
        end
        hold on;
    end
    hold off;
    axis equal;
    grid on;
    legend(Legends);
    legend('Location', 'NorthEastOutside');
end
