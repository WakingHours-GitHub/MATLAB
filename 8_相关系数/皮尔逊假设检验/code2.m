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
STD = std(data); % 每一列的标准差

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
R = corrcoef(data) % 一个参数的时候返回两个值，一个是相关系数，一个是P

% 然后放在Excel进行数据化处理


%% 皮尔逊假设检验部分：
% 参数设置：
conint = 0.975; %  confidence interval 置信区间
n = 28 % 自由度

x = -4:0.1:4; % 得到一个-4到4间隔为0.1的等差序列
y = tpdf(x, n); % 这是t分布的概率密度函数，x为自变量，28为自由度
figure(2)
plot(x,y,'-') % 画出曲线图
grid on; % 显示网格线
hold on; % 继续在figure2画图
% 求上a分位数（临界值）tinv为t分布的概率密度的反函数
% tinv(conint, n)

% 画出接受域和拒绝域的分割线
% 前面是x，后面是x对应的y，第一个点是(tinv,0) 第二个点是（tinv, tpdf(tinv)) 所以正好是一条竖线
plot([tinv(conint, n), tinv(conint, n)], [ 0, tpdf(tinv(conint, n),n)],'r-') % 右边
plot([-tinv(conint, n), -tinv(conint, n)], [ 0, tpdf(-tinv(conint, n),n)],'r-') % 左边

%% 计算p值（这部分没太听懂）


x = -4:0.1:4;
y = tpdf(x, n);
figure(3)
plot(x,y,'-');
% legend
grid on; 
hold on;
plot([-3.055,-3.055],[0,tpdf(-3.055,28)],'r-')
plot([3.055,3.055],[0,tpdf(3.055,28)],'r-')
disp('该检验值对应的p值为：')
disp((1-tcdf(3.055,28))*2)  %双侧检验的p值要乘以2




[R, P] = corrcoef(data)







%% 利用SPSS做
% [分析] [相关] [双变量]
% 可以选择相关系数:皮尔逊, 斯皮尔曼
% 双尾,单尾 其对应双侧和单侧

























