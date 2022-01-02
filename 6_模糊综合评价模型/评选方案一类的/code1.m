
clear; clc
load data.mat

%% 确定：因素集，评语集，权重
% 因素集：各种项目(第一行)
% 评语集：各种方案(第一行)
% 权重: 由"专家"给出(自己编,找),有数据的情况下可以由熵权法获得,或者也可以由AHP来确定

A = [0.25 0.20 0.20 0.1 0.25];

%% 确定隶属函数

fa = @(x) x/8800;
fb = @(x) 1-x/8000;
a1 = 5.50000;a2 = 8.0;
fc = @(x) 1 .* (x>=0 & x<=a1) + ((a2-x)/(a2-a1)).*(x>a1 & x<=a2) + 0.*(x>a2);

fd = @(x) 1 - x/200;

b1 = 1500;b2 = 50;
fe = @(x) ((x - b2 ) / (b1 - b2));

%% 计算综合评判矩阵

judgmentMatirx = [fa(data(1,:)); fb(data(2,:)); fc(data(3,:)); fd(data(4,:)); fe(data(5,:)) ];

result = A*judgmentMatirx;
disp('最终的综合评价：')
disp(result);

[sorted, index] = sort(result,'descend')
disp(['于是我们选用第' num2str(index(1)) '个方案'] )