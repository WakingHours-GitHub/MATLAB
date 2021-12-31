clear; clc

%% 一维度数据
x = -pi:pi
y =sin(x)
new_x = -pi : 0.01 : pi

p1 = pchip(x, y, new_x) % 三次埃尔米特插值(一阶导数相等)
p2 = spline(x, y, new_x) % 三次样条插值(二阶导数也相等)
% 上面的两种函数都是根据已有x,y,然后插入新的x返回新的y
% New_Y = pchip(Old_X, Old_Y, New_X)
% New_Y = spline(Old_X, Old_Y, New_X)

figure(1)
subplot(2,2,1)
plot(x,y,"go",new_x, p1 ,"b-", new_x,p2,'r-')
legend("样本点",'三次埃尔米特插值','三次样条插值', 'Location' ,'SouthEast') % 设置参数


clear; clc


%% n维数据
x = -pi:pi
y = sin(x)
new_x = -pi:0.01:pi;
p = interpn(x,y,new_x,'spline') % 多维插值，应用spline算法
% figure(2) % 有了subplot 直接把多张图画到一个表上去
subplot(2,2,2)
plot(x,y,"ro",new_x,p,'b-')
legend("样本点", "多维三次样条插值")

clear; clc


%% 预测
% population=[133126,133770,134413,135069,135738,136427,137122,137866,138639, 139538];
% year = 2009:2018;
load data.mat
new_x = 2019:2023;
p1 = pchip(year, population, new_x);
p2 = spline(year, population, new_x);

% figure(2)
subplot(2,2,[3,4])
plot(year, population, 'o',new_x, p1 ,'b+-', new_x,p2,'r*-')
legend("样本点","三次埃尔米特插值预测","三次样条插值预测",'Location','southeast')











