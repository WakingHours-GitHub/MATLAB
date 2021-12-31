clear; clc
load data_water_quality.mat; % X 存放的是四个指标
load X_name.mat; % X_name 存放的是四列的名字

% 对指标进行正向化：
[n, m] = size(X);
disp([ '共有' num2str(n) '个评价对象, ' num2str(m) '个评价指标'])
Judge = input(['这' num2str(m) '个评价指标是否需要正向化? (1需要，0不需要）'])

if Judge == 1 % 需要正向化的列标号
    disp(X_name(1,:)) % 打印这几列的名字
    fprintf("哪一列需要正向化：\n ")
    Position = input("请用矩阵形式[ ]输入:") % 需要正向化的列标号
    
    fprintf("请分别输入这几列是哪种指标类型\n (1为极小型，2为中间型，3为区间型)\n")
    
	for i = 1 : size(Position, 2)
		fprintf("第%d列 ",Position(i))
    end
    Type = input("分别是什么指标类型\n请用矩阵[]输入"); % 输入这几列的指标类型
    
    % 这里还需要加入一个说明性语句
    
    for i = 1 : size(Position, 2)  % 对非极大型指标，指标正向化，对每一列进行正向话
        X(:, Position(i)) = Positivization(X(:,Position( i)), Type(i), Position(i)); 
    end
	
    disp('正向化后的矩阵')
    disp(X)
	
else
    disp('不需要正向化，继续下一步')

end

%% 对正向画后的矩阵进行预处理
Mean = mean(X, 1) %得每一列的平均值
Z = X ./ repmat(Mean, size(X,1), 1); % 复制成同阶，然后相除，标准化
disp('预处理后的矩阵为：');disp(Z)

%% 构造母序列和子序列
% 与应用1不同。这里母序列为虚拟的，用每一行的最大值构成的列向量表示母序列
Y = max(Z,[],2); % 一行的最大值为列向量
X = Z; % 子序列就是预处理后的数据矩阵

%% 计算得分
absX0_X1 = abs(X - repmat(Y,1,size(X,2))) % 计算|X0 - Xi|矩阵
a = min(min(absX0_X1)); % 计算两级最小差
b = max(max(absX0_X1)); % 计算两级最大差
rho = 0.5; % 分辨系数

gamma = (a + rho*b) ./ (absX0_X1 + rho*b) % 计算子序列中各个指标与母序列的关联系数
weight = mean(gamma) / sum(mean(gamma)); % 利用子序列中的各个指标的灰色关联度计算权重（行向量）

score = sum(X .* repmat(weight,size(X,1),1),2) % 未归一化的得分(列向量）

Stand_socre = score ./ sum(score)
[sorted index] = sort(Stand_socre,'descend') % 进行排序















