% 主程序：NaSch_3.m程序代码
% 单车道 最大速度3个元胞 开口边界条件 加速 减速 随机慢化
clf
clear all
%build the GUI
%define the plot button
plotbutton=uicontrol('style','pushbutton',...
'string','Run', ...
'fontsize',12, ...
'position',[100,400,50,20], ...
'callback', 'run=1;');
%define the stop button
erasebutton=uicontrol('style','pushbutton',...
'string','Stop', ...
'fontsize',12, ...
'position',[100,500,50,20], ...
'callback','freeze=1;');
%define the Quit button
quitbutton=uicontrol('style','pushbutton',...
'string','Quit', ...
'fontsize',12, ...
'position',[100,600,50,20], ...
'callback','stop=1;close;');
number = uicontrol('style','text', ...
'string','1', ...
'fontsize',12, ...
'position',[20,400,50,20]);
%CA setup
n=1000; %数据初始化
z=zeros(1,n); %元胞个数
z=roadstart(z,200); %道路状态初始化，路段上随机分布200辆
cells=z;
vmax=5; %最大速度
v=speedstart(cells,vmax); %速度初始化
x=1; %记录速度和车辆位置
memor_cells=zeros(3600,n);
memor_v=zeros(3600,n);
imh=imshow(cells); %初始化图像白色有车，黑色空元胞
set(imh, 'erasemode', 'none')
axis equal
axis tight
stop=0; %wait for a quit button push
run=0; %wait for a draw
freeze=0; %wait for a freeze（冻结）
while (stop==0 & x<11502)
      if(run==1)
          %边界条件处理，搜素首末车，控制进出，使用开口条件
          a=searchleadcar(cells);
          b=searchlastcar(cells);
          [cells,v]=border_control(cells,a,b,v,vmax);
          i=searchleadcar(cells); %搜索首车位置
          for j=1:i
               if i-j+1==n
                  [z,v]=leadcarupdate(z,v);
                   continue;
               else 
                   %======================================加速、减速、随机慢化
                   if cells(i-j+1)==0; %判断当前位置是否非空
                   continue;
                   else v(i-j+1)=min(v(i-j+1)+1,vmax); %加速
                        %=================================减速
                        k=searchfrontcar((i-j+1),cells); %搜素前方首个非空元胞位置
                        if k==0; %确定于前车之间的元胞数
                           d=n-(i-j+1);
                        else d=k-(i-j+1)-1;
                        end
                        v(i-j+1)=min(v(i-j+1),d);
                        %==============================%减速
                        %随机慢化
                        v(i-j+1)=randslow(v(i-j+1));
                        new_v=v(i-j+1);                       
                       %======================================加速、减速、随机慢化
                        %更新车辆位置
                       z(i-j+1)=0;                    
                       z(i-j+1+new_v)=1;
                      %更新速度
                      v(i-j+1)=0;
                      v(i-j+1+new_v)=new_v;
                   end
               end
          end
          cells=z;
          memor_cells(x,:)=cells; %记录速度和车辆位置
          memor_v(x,:)=v;
          x=x+1;
          set(imh,'cdata',cells) %更新图像
          %update the step number diaplay
          pause(0.0001);
          stepnumber = 1+str2num(get(number,'string'));
          set(number,'string',num2str(stepnumber))
      end
      if (freeze==1)
         run = 0;
         freeze = 0;
      end
      drawnow
end
figure(1)
for l=11001:1:11500
    for k=1:1:1000
    if memor_cells(l,k)>0
        plot(k,l,'k.');
   
        hold on;
    end
    end
end
xlabel('空间位置')
ylabel('时间（s）')
title('时空图')


for i=1:1:500
   density(i)=sum(memor_cells(i,:)>0)/1000;
   flow(i)=sum(memor_v(i,:))/1000;


end
figure(2)
   plot(density,flow,'k.');

title('流量密度图')
xlabel('density')
ylabel('flow')
% 
% ///////////////////////////////////////////////////////////////////////
% 
% 
 
% 函数：searchlastcar.m程序代码

function [location_lastcar]=searchlastcar(matrix_cells)
%搜索尾车位置
for i=1:length(matrix_cells)
    if matrix_cells(i)~=0
       location_lastcar=i;
       break;
    else %如果路上无车，则空元胞数设定为道路长度
       location_lastcar=length(matrix_cells);
    end
end
end
% 函数：searchfrontcar.m程序代码

function  [location_frontcar]=searchfrontcar(current_location,matrix_cells)
i=length(matrix_cells);
if current_location==i
   location_frontcar=0;
else
    for j=current_location+1:i
       if matrix_cells(j)~=0
          location_frontcar=j;
       break;
       else
          location_frontcar=0;
       end
    end
end
end
% 函数：roadstart.m程序代码

function [matrix_cells_start]=roadstart(matrix_cells,n)
%道路上的车辆初始化状态，元胞矩阵随机为0或1，matrix_cells初始矩阵，n初始车辆数
k=length(matrix_cells);
z=round(k*rand(1,n));
for i=1:n
    j=z(i);
    if j==0 
       matrix_cells(j)=0;
    else
       matrix_cells(j)=1;
    end
end
matrix_cells_start=matrix_cells;
end
% 函数：randslow.m程序代码

function [new_v]=randslow(v)
p=0.3; %慢化概率
rand('state',sum(100*clock)*rand(1));%?¨?????ú??×?
p_rand=rand; %产生随机概率
if p_rand<=p
   v=max(v-1,0);
end
new_v=v;   
end
% 函数：leadcarrupdate.m程序代码
function [new_matrix_cells,new]= leadcarupdate(matrix_cells,v)
%第一辆车更新规则
n=length(matrix_cells);
if v(n)~=0
   matrix_cells(n)=0;
   v(n)=0;
end
new_matrix_cells=matrix_cells;
new_v=v;
end
% 函数：searchleadcar.m程序代码

function [location_leadcar]=searchleadcar(matrix_cells)
i=length(matrix_cells);
for j=1:i
    if matrix_cells(i-j+1)~=0
       location_leadcar=i-j+1;
       break;
    else
       location_leadcar=0;
    end
end
end
% 函数：speadstart.m程序代码
function [v_matixcells]=speedstart(matrix_cells,vmax)
%道路初始状态车辆速度初始化
v_matixcells=zeros(1,length(matrix_cells));
for i=1:length(matrix_cells)
    if matrix_cells(i)~=0
       v_matixcells(i)=round(vmax*rand(1));
    end
end
end
