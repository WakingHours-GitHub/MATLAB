clear; clc
%% contour函数： 用来绘制等高线图

% contour： 轮廓， 等高线
% 当一个语句太长时, 可以加上三个点然后在下一行继续写. ...不会被编译
[x, y] = meshgrid(linspace(-5, 5, 100));
z =  3*(1-x).^2.*exp(-(x.^2) - (y+1).^2)...  
    -10* (x/5 - x.^3 - y.^5).*exp(-x.^2-y.^2) ...
    - 1/3*exp(-(x+1).^2 - y.^2);  % matlab中内置的peaks函数，常常作为演示使用
% mesh(x, y, z)
% edit peaks -> 直接在命令行生成函数
% peaks是matlab展示用的命令, 直接生成一个图像.

%% contour(x, y, z) -> 在xoy平面绘制等高线图, MATLAB会自动选择等高线的层级
% 例如:
contour(x, y, z)
xlabel('x轴'); ylabel('y轴');

%% contour(x, y, z, n) 在xoy平面绘制等高线图, n是一个标量, 那么matlab会将等高线层数设置为n,并且自动选择等高线的高度
contour(x, y, z, 5); % 选择n=5, 为5层
contour(x, y, z, 5, 'LineWidth', 2); % 设置线宽, 可以显示的更清楚
contour(x, y, z, 5, '--'); % 设置等高线为虚线
contour(x, y, z, 5, 'ShowText', 'on', 'LineWidth', 2);contour(x ,y, z, 5, 'ShowText', 'on'); % 显示等高线高度, 用文字显示
 % 组合使用
colorbar % 显示颜色栏, 当然也可以在figure中直接插入
xlabel('x轴'); ylabel('y轴');

%% 手动选择分层高度
%% contour(x, y, z, levels) 若想得到固定的n个高度的等高线, 可以将levels设置为n元行向量, 其中向量中的值为高度值
maxz = max(max(z));  % 或者是max(z(:)), z(:)是所有元素按列遍历, 然后再求max, 所以只需要一个max即可
minz = min(min(z)); 
leverls = linspace(minz, maxz, 10); % 生成序列: % 从最小值到最大值，等分成10个点 linspace()函数 
figure(2)
contour(x, y, z, leverls, 'ShowText', 'on', 'LineWidth', 1); % n=levels, 为等高线等级
xlabel('x轴'); ylabel('y轴');

%% 思考一个事情: 若只想画出高度为3的单等高线怎么办?
% 就是在n=[h h] 这样的范围就是h到h, 这样就可以显示单等高线
contour(x, y, z, [3 3], 'ShowText', 'on', 'LineWidth', 2);
xlabel('x轴'); ylabel('y轴');

%% contour()其他的函数:
%% contourf()函数, 和contour()函数和很类似, 只不过画出来的等高线有颜色填充
% 这样使得图像更加明显
contourf(x, y, z, leverls, 'ShowText', 'on');

%% contour3()函数, 三维等高线, 等高线在立体平面上
% 就是在立体平面上
contour3(x, y, z, leverls, 'ShowText', 'on');



