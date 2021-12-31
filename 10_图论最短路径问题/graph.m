clear; clc

%% 图论基础知识
% 利用MatLab作图

%% MatLab作无向图:graph()函数

% (1) 无权重(就是每条边的权重默认为1)
% graph(s, t, [w]): 可在s,和t对应的节点之间创建一条边(一一对应), 返回一个graph对象(图)
% 然后放在plot(G)画出即可, s和t是同维
% 若需要加上权重, 则后面在加上权重

s1 = [1 2 3 4];
t1 = [2 3 1 1];

figure(1)
G1 = graph(s1,t1)
plot(G1)

% 注意: 编号从1开始,连续编号,不要跨越,或者自己随意编号
% 若跨越中间的数值, matlab画图的时候就会被孤立, 若matlab画图不合适, 就在网站中画图
% 例如:
s1 = [ 1 2 3 5];
t1 = [ 2 3 5 1];
figure(2)
G1 = graph(s1, t1) % 此时
plot(G1)

% 字符串也是可以用matlab画出来的,需要用到元胞数组
s2 = {'学校','电影院','网吧','酒店'};
t2 = {'电影院','酒店','酒店','KTV'};
figure(3)
G2 = graph(s2, t2)
plot(G2, 'linewidth', 2) % 设置参数linewidth线宽,为2
set(gca, 'XTick', [], 'YTick', []); % set设置, gca是设置坐标轴,然后横纵坐标为空
% 不过现在2019a画Graph对象，自动就吧坐标轴删除了

% (2)有权重:需要加上权重, 则后面在加上权重w矩阵
s3 = [1,2,3,4];
t3 = [2,3,1,1];
w3 = [3,8,9,2];
figure(4)
G3 = graph(s3, t3, w3);
plot(G3, 'EdgeLabel', G3.Edges.Weight, 'linewidth', 2) % EdgeLabel边的标签, G3.Edges.Weight
set(gca, 'XTick', [], 'YTick', []);



%% 利用MatLab作有向图：digraph()
s4 = [1 2 3 4 1];
t4 = [2 3 1 1 4];
G4 = digraph(s4, t4);
figure(5)
plot(G4)

% 有权图
s5 = [1 2 3 4 1];
t5 = [2 3 1 1 4];
w5 = [3 8 1 2 3];
G5 = digraph(s5, t5, w5);
figure(6)
plot(G5, 'EdgeLabel', G5.Edges.Weight, 'linewidth', 2)
set(gca, 'XTick', [], 'YTick', []);







