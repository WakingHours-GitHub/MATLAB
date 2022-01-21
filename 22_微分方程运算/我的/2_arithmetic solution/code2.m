%% 使用求解器 求解微分方程
% 调用ode45函数求解微分方程df1，自变量为x，范围为[0,2],  初始值y(0)=3 ; 因变量为y
% 求解： y' = y - 2x 
% 先查看是否有解析解:
syms_y = dsolve("Dy=y-2*x", "y(0)=3", "x");
figure(1)
subplot(1, 3, 1)

fplot(syms_y, '-', [0 2]);
title('source figure');

% 但是我们还是来求解一下数值解

% matlab中求解微分方程的数值解的函数如下:
% [x y] = solver('f', xs, yo, options);
% x表示自变量的取值, 也就是solver分割求解的点
% y表示表示因变量的取值, 也就是x点对应的y值, 若y是一个矩阵, 则第一列表示y, 第二列表示y', 以此类推
% solver: 表示求解函数, 常见的函数有7中
% xs=[x0, xf] 代表自变量的初值和终止, 也可以指定一个向量
% y0表示函数的初始值, 即y(x0) = y0
% options=odeset('retol', rt, 'obstol', at), 其中lt,at分别为设定的相对误差和绝对误差

hold on;
[x, y] = ode45('df2', [0 2], 3);
subplot(1, 3, 2);
plot(x, y, '+-') % 可以看到我们的求解器求解精度还是可以的
title("obe45");

% 增强求解精度,
% 设定相对误差和绝对误差, 这样可以提高微分方程求解数值解的精度
options = odeset('reltol', 1e-4, 'abstol', 1e-8);
[x, y] = ode45('df2', [0 2], 3, options);


%  如果觉得x的间隔不够小，我们可以指定要求解的位置
[x,y] = ode45('df2', [0:0.001:2], 3, options);
subplot(1, 3, 3);
plot(x, y, '+g', 'MarkerSize', 1)
title('time ode45');

