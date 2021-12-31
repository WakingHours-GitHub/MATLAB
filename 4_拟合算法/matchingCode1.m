clear; clc
load data1.mat; % data

% %% 一个小例子
% figure(1)
% plot(data(:,1), data(:,2),'o')
% xlabel("x的值")
% ylabel('y的值')

%% 求解最小二乘法
%% 公式记笔记
clear; clc
load data1.mat
x = data(:,1);
y = data(:,2);
figure(2)
plot(data(:,1),data(:,2),'o')
% 显示x,y轴标签
xlabel('x的值')
ylabel('y的值')
n = size(data(:,1),1)

% 公式计算线性拟合(这个用的是数理统计中类似与一致性或者极大似然估计计算出来的)
% n代表样本个数，即对列求个数，得行数
k = (n*sum(x.*y) - sum(x)*sum(y) )/ ( n*sum(x.*x) - sum(x)*sum(x));
b = ( sum(x.*x)*sum(y) - sum(x)*sum(x.*y))  / (n * sum(x.*x) - sum(x)*sum(x))

hold on % 继续再上一个图画
grid on % 显示网络格

% 匿名函数
% handle = @(argList)anonymous_function
% handle就是再调用匿名函数时的名字
f = @(x) k*x+b % 类似与宏定义
% fplot函数可用于画出匿名1一元函数的图形
% fplot(f, xinterval)将匿名函数f在指定区间xinterval绘图
% xinterval = [xmin, xmax]表示定义域的范围, 所以传参时，传入两个参数几个，而不是矩阵
fplot(f,[2.5,7]) % 这个有点忘了
legend('样本数据','拟合函数','location','southEast') % 加legend




%% 计算拟合优度
y_hat = f(x) % 拟合函数
SST = sum((y - mean(y)).^2)
SSE = sum((y - y_hat).^2 )
SSR = sum((y_hat - mean(y)).^2)

if(SST - SSE - SSR <= 1e-8)
    disp('该拟合函数为参数线性')
else
    disp('该拟合函数为非线性')
end

R_2 = SSR / SST








