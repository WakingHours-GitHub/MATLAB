%% mesh函数使用
% 绘制三维图像:
Z = [
    1 2 3;
    2 3 4
];
mesh(Z);

%% 例子

%% 例题1：绘制 z = x^2 - y^2的图像 ，其中x和y都位于[0,5]之间
n = 19; % 个数
temp = linspace(0,5, n); % 产生数据序列
% linspace（x1, x2, n) -> 在x1到x2范围内等分n个元素
x = repmat(temp, n, 1);
y = repmat(temp', 1, n);
z = x.^2 - y.^2; % f法则
figure(1); % figure 标号
mesh(x, y, z);
xlabel('x轴'); ylabel('y轴'); zlabel('z轴') % 显示坐标轴

%% 例题2： 绘制 z = sin(sqrt(x^2+y^2))/sqrt(x^2+y^2)的图形, 其中x和y都位于[-5, 5]之间
% 直接使用meshgrid(序列); 快速生成网格所需的数据
[x, y] = meshgrid(-10:0.5:10);
% temp = sqrt(x.^2 + y.^2); 这样绘制的时候，我们发现少了一点。
temp = sqrt(x.^2 + y.^2)+eps; % 在后面加上一个很小的数字，这样点就显示出来了
z = sin(temp) ./ temp;  
mesh(x, y, z);
axis vis3d

%% 利用meshc函数绘制等高线
[x, y] = meshgrid(linspace(-10, 10, 100));
figure(2);
temp = sqrt(x.^2 + y.^2) + eps;
z = sin(temp) ./ temp;
meshc(x, y, z)
xlabel('x轴'); ylabel('y轴'); zlabel('z轴');
axis vis3d

%% meshz函数绘制底座, 也就是填充f在xoy上的投影
figure(3)
meshz(x, y, z)
alpha(0.5);


%% 三张图一起放在这里:
% 使用subplot(m, n, index)
% 使用subplot函数绘制子图。
[x, y] = meshgrid(linspace(-5, 5, 100));
temp = sqrt(x.^2 + y .^2) + eps;
z = sin(temp) ./ temp + 2;
lever = [-5 5 -5 5 -5 5];
figure(4);

subplot(1, 3, 1);
mesh(x, y, z);
axis vis3d
title("mesh(x, y, z)");

subplot(1, 3, 2);
meshc(x, y, z);
set(gca,"ztick", (-1:0.5:1));
axis vis3d
title("meshc(x, y, z)")

subplot(1, 3, 3);
meshz(x, y, z);
alpha(0.6)
axis vis3d
title("meshz(x, y, z)")


















