clear;clc
%% 符号函数的三维图形绘制
% 符号变量之前已经介绍过了, 所以这里就不在介绍
syms x; % 这就是一个符号变量

clear; clc
%% 绘制参数方程类型的函数
% plot3()函数 (类似于plot函数,实际上可以认为是画三维空间的这戏那图
% t = 0: 0.1: 4*pi; % 生成序列向量
t = linspace(0, 4*pi, 100); % 生成序列
x = sin(t)+1;
y = cos(t);
z = t;
plot3(x, y ,z); % 绘制三维空间下的折线图
plot3(x, y, z, 'r--'); % 对于plot的option同样对于plot3()也可以使用
close; % 关闭图形

%% fplot3()函数， 老版本的MATLAB使用的是ezplot3函数， 未来版本可能会被淘汰
%% fplot3()函数 -> 绘制符号变量.
syms t % 定义符号函数
x = sin(t)+1;
y = cos(t);
z = t;
fplot3(x ,y, z); % 默认t的变化范围为[-5, -5]
% 我们也可也传入参数, 来指定t的范围
fplot3(x, y, z, [0 4*pi]); % 修改t的变化范围为0~4pi

%% fmesh()函数 -> 符号变量的三维网格图.(2016a推出的函数, 老版本使用的是ezmesh函数)
syms x y;
z = x^2 + y^2; % 这里x,y是符号变量, 所以运算符不需要加.
fmesh(z);
% edit doc fmesh, 查看文档
% fmesh(f,xyinterval) 将在指定区间绘图。要对 x 和 y 使用相同的区间，请将 xyinterval 指定为 [min max] 形式的二元素向量。要使用不同的区间，请指定 [xmin xmax ymin ymax] 形式的四元素向量。
% axis vis3d  % 冻结屏幕高宽比，使得一个三维对象的旋转不会改变坐标轴的刻度显示
% axis equal  % 设置屏幕高宽比，使得每个坐标轴的具有均匀的刻度间隔, 更好的观察比例, 显示图像真实的样子
fesh(z,[ -2 2 -4 4], 'MeshDensity', 11);  % 设置每个方向计算的点数

%% 例子: 画一朵花:
syms u v;
% 错误写法: 
% r = 2 + sin(7.*u + 5.*v);
% x = r.*cos(u).*sin(v);
% y = r.*sin(u).*sin(v);
% z = z.*cos(v);
% 符号变量只能直接用乘号, 只有向量或者矩阵中的元素运算时才使用
r = 2 + sin(7*u + 5*v);
x = r*cos(u)*sin(v);
y = r*sin(u)*sin(v);
z = r*cos(v);
fmesh(x, y, z, [0 2*pi 0 pi]);
alpha(0.6); % 设置透明度
colorbar;
axis vis3d; % 冻结坐标轴
axis equal; % 坐标轴的间隔点数相同


%% fsurf()函数 符号变量的三维曲面图 (老版本MATLAB使用的是ezsurf函数)
syms x y; % 定义符号变量
z = x^2 + y^2;
fsurf(z); % 直接调用fsurf函数,  默认x,y的范围都是[-5, 5]之间
fsurf(z, [-10 10 -10 10]);
% axis vis3d  % 冻结屏幕高宽比，使得一个三维对象的旋转不会改变坐标轴的刻度显示
% axis equal  % 设置屏幕高宽比，使得每个坐标轴的具有均匀的刻度间隔, 更好的观察比例, 真实的样子
% MeshDensity -> 网格密度, 后面的数字,表示x,y计算点的个数  
fsurf(z, [-10 10 -10 10], 'MeshDensity', 10);
% 看一下MeshDensity的作用 (区别)
figure(2);
subplot(1, 2, 1);
title("MeshDensity: 10");
fsurf(z, [-10 10 -10 10], "MeshDensity", 10);
axis vis3d;
subplot(1, 2, 2);
title("MeshDensity: 100");
fsurf(z, [-10 10 -10 10], "MeshDensity", 100);
axis vis3d;
% 显然MeshDensity: 控制的是x,y方向上的点的个数
% 越大越密, 越小越稀疏.

%% fcontour()函数, 绘制符号变量等高线(老版本使用的是ezcontour()函数)
syms x y;
z = x^2 + y^2;
fcontour(z);
fcontour(z) % 默认x的变化范围和y的变化范围都是[-5 5]
fcontour(z,[-2 2 -4 4]) % 修改x的变化范围和y的变化范围分别为[-2 2]和[-4 4]
fcontour(z,'fill','on') % 在等高线线条间进行填充, 填充颜色.

























