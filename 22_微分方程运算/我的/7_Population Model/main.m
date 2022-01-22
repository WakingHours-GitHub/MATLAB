%% 求解解析解:
clear;clc
% close all

%% 求解Malthus模型
% 直接使用dsolve()进行求解
x = dsolve("Dx=r*x", "x(0)=x0", "t")
% 使用Matlab推荐的写法:
syms x(t) t r; % r也要加上
equ = (diff(x,t) == r*x)
x = dsolve(equ, 'x(0)=x0', 't')
% 得到结果后, 我发现里面有两个未知量, 分别是x0(初始值), r(增长率)
% 于是我们先对进行复制
x0 = 100; % 初始的人口数
r = 0.1; % 人口增长率
x = subs(x) % 替换, 就是将里面的未知量, 替换成工作区同名的变量
% 这样就将x被替换了.

x = dsolve("Dx=r*x", "x(0)=x0", "t")
% 画出图形
% 初始人口为1000，画出50年且增长率分别为0.5%，1%，1.5% 一直到5%的人口变化曲线
figure(1);
x0 = 1000;
r = 0.005;
for i = 1: 10
    r = 0.005 * i;
    current_x = subs(x);
    fplot(current_x, [0, 50]); % 画出图像, 并且设置level
    
    hold on;
end
title("Malthus Model");
xlabel("time"); ylabel("population");


%% 求解logistic模型(阻滞增长模型)
clear; clc
% 求解:
x = dsolve("Dx=r*(1-x/xm)*x", "x(t0)=x0", "t")
simplify(x)




