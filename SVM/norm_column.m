
%按列归一化处理
function newdat = norm_column(dataMat)
len = size(dataMat,1);
maxV = max(dataMat);
minV = min(dataMat);
range = maxV - minV;
newdat = (dataMat-repmat(minV,[len,1]))./(repmat(range,[len,1]));
end