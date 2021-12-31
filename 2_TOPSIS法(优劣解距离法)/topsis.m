%% TOPSIS法，即优劣解距离法

%% 第一步：把数据复制到工作区中，然后保存到文件中
%% 并用load从文件中读取
clear; clc
load data_water_quality.mat % 从.mat文件加载到matlab X为原始数据矩阵
load X_name.mat

%% 第二部：判断是否需要正向化（指标正向化）
%% 这部分涉及多个函数。matlab的函数规则是每个文件有一个函数
%% 格式如下：function [返回] 函数名(参数列表)
[n m] = size(X);% 不显示 % 获取矩阵的行和列数 （一列是一个评价指标，一行是一个评价对象）
disp(['共有' num2str(n) '个评价对象, 和' num2str(m) '个评价指标']) 
Judge = input(['这' num2str(m) '个评价指标是否需要正向化? (1需要，0不需要）'])
if Judge == 1
    
    disp(X_name(1,:))
    fprintf("哪一列需要正向化：\n ")
    Position = input("请用矩阵形式[ ]输入:") % 需要正向化的列标号
    fprintf("请分别输入这几列是哪种指标类型\n 1为极小型，2为中间型，3为区间型\n")
    
    Type = input("用矩阵[]输入"); % 输入这几列的指标类型
    
    % 这里还需要加入一个说明性语句
    
    for i = 1 : size(Position, 2)  % 对非极大型指标，指标正向化
        X(:, Position(i)) = Positivization(X(:,Position( i)), Type(i), Position(i)); 
         
    end
    disp('正向化后的矩阵')
    disp(X)
    
else
    disp('不需要正向化')

end





%% 第三步：对正向化的矩阵进行标准化（xi除以 列平方和 开方）
Z = X ./ repmat(sum(X.*X) .^ 0.5, n, 1)



%% 第四步：计算与最大值的近距离和最小值的距离，并且算出得分
% 计算得分归一化
D_P = (sum(((Z -  repmat(max(Z), n, 1)) .^ 2) , 2)) .^ 0.5
D_N = (sum(((Z -  repmat(min(Z), n, 1)) .^ 2) , 2)) .^ 0.5
S = D_N./(D_P + D_N);
disp("未归一化的的得分" )
disp(S)
disp("归一化后的得分:  ")
Stand_S =  S/sum(S)
[ sorted_S, index] = sort(Stand_S, 'descend') % 排序函数








%% 补充知识
% A = magic(5) % 返回一个五阶幻方矩阵
% M = magic(n) % 返回由1到n^2的整数构成并且总行数和总列数相等的n×n矩阵。阶次n必须为大于或等于3的标量。

% sort(A, dim) -- 排序函数，默认为升序排列
% dim = 1 时, 等效sort(A) 默认对列升序排序
% dim = 2 时, 对和升序排列
% 若需要降序排列: 则需要加一个参数: descend
% 即:sort(A,'descend') 就是对A的每一列降序排列






