clear; clc

%% 蒙特卡罗模拟：内生性会造成回归系数的巨大误差
times = 300; % 蒙特卡洛模拟次数
R = zeros(times,1); % 存储扰动项u和x1的相关系数
K = zeros(times,1); % 用来用来存储遗漏变量（这里是x2）， y只对x1回归分析得到的回归系数
n = 30; % 样本数

for i = 1:times
    x1 = rand(n,1)*20 - 10; % 返回一个n*1的随机数矩阵, 范围扩大到[-10，10]
    u1 = normrnd(0,5,n,1) + rand(n,1); % 完全随机，normrd(mu, sigma, [n, m]) 返回一个n*m的正态分布的随机矩阵
    x2 = 0.3 * x1  + u1;
    u = normrnd(0,1,n,1); % 真正的残差（偏离值）
    y = 0.5 + 2 * x1 + 5 * x2 +u;
    k = (n*sum(x1.*y)-sum(x1)*sum(y))/(n*sum(x1.*x1)-sum(x1)*sum(x1)); % y = k*x1+b 回归估计出来的k(用最小二乘法)
    K(i) = k; % 存储相关系数
    u = 5 * x2 + u;
    r = corrcoef(x1, u) % 返回x1 和u的相关系数矩阵
    R(i) = r(1,2);
%         x1 u
%     x1 1   r
%     u   r   1
end

figure(1)
plot(R, K, '+r')
hold on
plot([0,0],[0,2],'b-')
hold on
plot([-0.1,0], [2,2],'b-')
% 添加标签
xlabel('x1和u相关系数')
ylabel('k的估计值')

% 可见当x1和u的相关系数越大(内生性越强), 则k_hat与k的偏离越来越大
