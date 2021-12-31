clear; clc
%% 导入数据
% 若.mat文件在文件中有空格，则需要加引号
load 'women wear data.mat' % data 
% 列是指标, 行是变量(对象) 

%% 进行统计性描述
% 默认都是dism = 1即对列操作
MIN = min(data); % 返回一个行向量,是每一列的最小值
MAX = max(data);
MEAN = mean(data) ;
MEDIAN = median(data); % 返回一个行向量, 每一列的中位数
SKEWNESS = skewness(data); % 每一列的偏度
KURTOSIS = kurtosis(data); % 每一列的峰度
% STD = std(data); % 每一列的标准差

RESULT = [MIN; MAX; MEAN; MEDIAN; SKEWNESS; KURTOSIS; STD] % 将指标组成一个矩阵
[n m] = size(RESULT)

% 将描述性统计得到的矩阵,处理美观后,插入到论文中去
% 描述性统计可以在SPSS中做

%% 计算各列相关系数
% 计算各列相关系数之前, 需要画出各个列之间的散点图, 确定是否线性相关

%% 画出散点图
% 用matab画出图形
figure(1)
p = 1
for i = 1 : size(data, 2)
    for j = i+1 : size(data,2)
        subplot(4,4,p)
		plot(data(:,i) , data(:,j) ,'ro')
        p = p+1
    end
    
end

% 实际上这里使用Spss比较方便: 图形 - 旧对话框 - 散点图/点图 - 矩阵散点图


%% 计算相关系数：
R = corrcoef(data)

% 然后放在Excel进行数据化处理








