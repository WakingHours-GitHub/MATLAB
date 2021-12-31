
clear; clc
load data.mat % data

[n m] = size(data)

% 预处理：标准化
stand_data = data./repmat(mean(data,1) ,n, 1);
disp('预处理后的矩阵')
stand_data

Y = stand_data(:, 1); % 母序列
X = stand_data(:, 2 : end); % 子序列

absx0_x1 = abs(X - repmat(Y, 1 ,size(X,2))) % 计算矩插值矩阵（先复制与X同阶的母序列，然后相减）
a = min(min(absx0_x1)) % 找最小
b = max(max(absx0_x1)) % 找最大

rho = 0.5 % 分辨系数(通常取0.5)
gema = (a + rho * b) ./ (absx0_x1 + rho*b)
disp('子序列中各个指标的灰色关联度分析：')
gema % 打印

% 对灰色关联分析标准化
disp('子序列灰色关联度分别为：')
sum(gema,1)/n