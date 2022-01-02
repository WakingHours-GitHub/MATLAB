
clear; clc
load data2.mat % year和population

[n,m] = size(year)
figure(1)
plot(year, population, 'o') 



%% 选择拟合函数
hold on;
grid on;

%% y = kx + b
k_hat =( n*sum(year.*population) - sum(year)*sum(population) ) / ( n * sum(year.*year) - sum(year)*sum(year))
b_hat=(sum(year.*year) *sum(population) - sum(year)*sum(year.*population) ) / (n * sum(year.*year) - sum(year) *sum(year))

f1 = @(x) k_hat * x+b_hat % 匿名函数，当给x为列向量时，得到的f1也同样为列向量

fplot(f1,[2008, 2018])

% 计算拟合优度
y1_hat = f1(year); % 实例化

SST = sum ( (population - mean(population)) .^2 )
SSE = sum ( ( population - y1_hat) .^2 )
SSR = sum ( (y1_hat - mean( population)).^2)

if SST - SSE - SSR <= 1e-8 % 浮点数计算存在一定误差，所以不能用==号判断
    disp('参数为线性')
     R2 = SSR/SST % 计算拟合优度
else
    disp('参数未线性')
end


%% 指数模拟
figure(2)
plot(year, population, 'o') 
hold on;
grid on; % 继续画图，并且画出网格线

% % 模拟参数
% a = ?
% b = ?


f2 = @(x) a*exp(b*x)

plot(year, f2(year), '-')

















