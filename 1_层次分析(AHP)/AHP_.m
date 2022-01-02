%% 层次分析法。

% 输入判断矩阵：
% 一般由专家给出，但是往往都是由我们算出
clear; clc
A =[1 1 4 1/3 3;
1 1 4 1/3 3;
1/4 1/4 1 1/3 1/2;
3 3 3 1 3;
1/3 1/3 2 1/3 1]

sum_A = sum(A,1) % 对列求和，得行向量
[n m] = size(A);

SUM_A = repmat(sum_A, n ,1) % 复制

Stand_A = A ./ SUM_A; 

wight1 = sum(Stand_A, 2) /n

s's's's's's
prod = prod(A , 2)
wight2 = prod.^(1/n) / sum( prod.^(1/n) )

[V, D] = eig(A) % 求特征向量和特征值构成的对角矩阵
Max_eig = max(max(D)) % 求那个最大的特征值
D == Max_eig % 返回一个逻辑数组
[r,c] = find(D == Max_eig, 1) % 在逻辑数组中找到第一个不为0的元素

% 此时最大特征向量对应的那列特征值就是我们需要的权重（未归一化）
V(:,c) 
% 归一化；
V(:,c) / sum(V(:,c))

clc

% 计算系数
CI = (Max_eig - n) / (n - 1)
RI=[0 0 0.52 0.89 1.12 1.26 1.36 1.41 1.46 1.49 1.52 1.54 1.56 1.58 1.59];  %注意哦，这里的RI最多支持 n = 13
CR = CI / RI(n)











