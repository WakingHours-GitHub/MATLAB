clc;clear
% 求解模型参数
% 相互依存模型, 不仅仅是种群例子, 也可以在企业的例子


% 情况1: 甲可以独立生存, 乙不能独立生存
% 使用dslove函数进行求解, 求解不出来
% 这里设定初始值分别为80, 100 
[t, x] = ode45(@fun1, [0 50], [80 100]);
figure(1);
subplot(2, 2, 1);
plot(t, x(:, 1), 'r-', t, x(:,2), 'b-');
legend("甲种群", "乙种群");
title(" 甲可以独立生存, 乙不能独立生存");
xlabel("time"); ylabel("count");


% 情况2: 甲, 乙均可以独立生存
[t, x] = ode45(@fun2, [0, 50], [80, 100]);
figure(2);
subplot(2, 2, 2);
plot(t, x(:, 1), "r-", t, x(:, 2), "b-");
legend("甲","乙");
title("甲,乙均可以独立生存");
xlabel("time"); ylabel("count");

% 情况3: 甲, 乙, 均不能独立生存
[t, x] = ode45(@fun3, [0, 50], [80, 100]);
figure(3);
subplot(2, 2, 3);
plot(t, x(:, 1), "r-", t, x(:, 2), "b-");
legend("甲","乙");
title("甲,乙均不可以独立生存");
xlabel("time"); ylabel("count");

% 情况4: 微分方程不平衡的情况:
% 我们需要缩小自变量范围
[t, x] = ode45(@fun4, [0, 4.5], [80, 100]);
figure(4);
subplot(2, 2, 4);
plot(t, x(:, 1), "r-", t, x(:, 2), "b-");
legend("甲","乙");
title("sigma1 \times sigma2 > 1");
xlabel("time"); ylabel("count");
% 可以看到已经呈指数级增长了.










