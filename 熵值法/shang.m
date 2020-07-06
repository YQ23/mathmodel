function [newdat,p,e,w,score] = shang(data,type)
  [m,n] = size(data);
  newdat = zeros(m,n);%newdat代表标准化处理后的数据
  if(type==1)
    mean_dat = zeros(1,n);
    min_dat = zeros(1,n);
    max_dat = zeros(1,n);
    for j = 1:n
        mean_dat(j) = mean(data(:,j));
        min_dat(j) = min(data(:,j));
        max_dat(j) = max(data(:,j));
    end
    %如果所用指标值越大越好(正向指标)，则选用newdat=(xj-xmin)/(xmax-xmin)
    %如果所用指标值越小越好(负向指标)，则选用newdat=(xmax-xj)/(xmax-xmin)
    range_dat = max_dat - min_dat;
    for j = 1:n
        for i = 1:m
            newdat(i,j) = (data(i,j)-min_dat(j))/range_dat(j);
            %另一种处理方法是
            %newdat(i,j)=(max_dat(j)-data(i,j))/range_dat(j);
        end
    end
    
    
  else if(type==2)
       mean_dat = zeros(1,n);
       std_dat = zeros(1,n);
       for j = 1:n
         mean_dat(j) = mean(data(:,j));
         std_dat(j) = std(data(:,j));
       end
       for j = 1:n
          for i = 1:m
              newdat(i,j) = (data(i,j)-mean_dat(j))./std_dat(j);
          end
       end
       add = ceil(abs(min(newdat)));
       newdat = newdat + add;
      end
  end
  
  p = zeros(m,n);%第j项指标下第i个城市占该指标的比重
  w_sum = zeros(1,n);
  for j = 1:n
      w_sum(j) = sum(newdat(:,j));
      for i = 1:m
        p(i,j) = newdat(i,j)./w_sum(j);
      end
  end
  
  p(p==0) = 0.0001;
  
  k = 1 ./ log(m);%常数k=lnm
  e = zeros(1,n);%信息熵值
  p_ln = p .* log(p);
  p_ln_col = sum(p_ln);
  for j = 1:n
     e(j) = -k .* p_ln_col(j);
  end
  d = 1 - e;
  
  w = zeros(1,n);%各属性权值
  for j = 1:n
      w(j) = d(j)./sum(d);
  end
  
  score = zeros(m,1);
  for i = 1:m
      score(i) = sum(data(i,:) .* w);
  end
  
end
