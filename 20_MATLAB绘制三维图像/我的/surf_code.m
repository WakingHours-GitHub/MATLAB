%% surf函数：绘制出在某一区间内完整的曲面图
% surf函数和mesh函数的的调用格式基本相同
% 两者的区别： mesh绘出彩色的线，surf绘出彩色的面
% mesh是以线为单位, surf是以面为单位


%% 例题1对比:
% 例题1：绘制 z = x^2 - y^2的图像 ，其中x和y都位于[0,5]之间
[x y] = meshgrid(linspace(0, 5, 10));
z = x.^2 - y.^2;
figure(1)
subplot(1,2,1);
mesh(x, y, z);
title('mesh(x,y,z)'); % 图的标题
xlabel("x轴"); ylabel("y轴"); zlabel("z轴");
axis vis3d;  

subplot(1,2,2);
surf(x, y, z);
title('surf(x, y, z)');
xlabel("x轴"); ylabel("y轴"); zlabel("z轴");
axis vis3d;
% axis命令可以设置坐标轴刻度范围. 
% axis([0,5,0,5,-inf,+inf])  % 设置坐标轴刻度范围


%% 例题2对比:
% 绘制z = sin(sqrt(x^2+y^2))/sqrt(x^2+y^2)的图形,
% 变化一下, x在0,10, y到-5到5
n = 100;
temp_x = linspace(0, 10, n);
x = repmat(temp_x, n, 1);
temp_y = linspace(-5 , 5, n);
y = repmat(temp_y', 1, n); 
figure(2)
temp = sqrt(x.^2+y.^2) + eps;
z = sin(temp) ./ temp;
surf(x, y, z)
xlabel('x轴'); ylabel('y轴'); zlabel('z轴'); 

% 大体上来说mesh函数和surf函数的使用是一样的.

%% 下面来讲讲surf函数独有的函数
%% surfc函数: 除了surf函数图形外, 还在xy平面上绘制曲面的等高线
figure(3)
surfc(x, y, z)
alpha(0.3)

% 注意，没有surfz这个函数，仅仅有meshz
%% surfl函数：加上了灯光效果,看起来自然点
surfl(x,y,z)
xlabel('x轴');  ylabel('y轴');  zlabel('z轴');  % 加上坐标轴的标签
axis vis3d % 冻结屏幕高宽比，使得一个三维对象的旋转不会改变坐标轴的刻度显示
%% surfl()函数可以更改显示模式
%% 设置色彩模式 -> 更改显示的设置
% shading 是用来处理色彩效果的，分以下三种：
% shading faceted是默认的模式 
% shading flat 在faceted的基础上去掉图上的网格线
% shading interp 在flat的基础上进行色彩的插值处理，使色彩平滑过渡
[x, y] = meshgrid(linspace(-5, 5, 50));
temp = sqrt(x.^2 + y.^2) + eps;
z = sin(temp) ./ temp;

figure(5)
subplot(1, 3, 1)
surf(x, y, z)
shading faceted % 默认
axis vis3d
title('shading faceted')

subplot(1, 3, 2)
surf(x, y, z)
shading flat
axis vis3d
title('shading flat')

subplot(1, 3, 3)
surf(x, y, z)
shading interp
axis vis3d
title('shading interp')



















