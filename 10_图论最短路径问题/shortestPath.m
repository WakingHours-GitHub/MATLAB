%% 最短路径算法

% 注意哦，Matlab中的图节点要从1开始编号，所以这里把0全部改为了9
% 编号最好是从1开始连续编号，不要自己随便定义编号
s = [9 9 1 1 2 2 2 7 7 6 6  5  5 4];
t = [1 7 7 2 8 3 5 8 6 8 5  3  4 3];
w= [4 8 3 8 2 7 4 1 6 6 2 14 10 9];

G = graph(s, t, w);
figure(1)
plot(G,'EdgeLabel',G.Edges.Weight, 'linewidth',2,)
set(gca,'XTick',[], 'YTick',[]);

% [P,d] = shortestpath(G,start,end [,'Method',algorithm] ) % Matlab在2015版本后才出现
% G是graph对象, start是开始节点的编号, end是目标节点的编号, 后面是可选的参数,表示最短路径的算法.
% p是最短路径经过的节点编号序列, d是距离
[p d] = shortestpath(G, 9 ,4) % 默认method 为 auto

% 高亮我们的最短路径
myplot = plot(G,'EdgeLabel', G.Edges.Weight, 'linewidth', 2)
highlight(myplot, p, 'EdgeColor', 'r') % highlight标记节点， 然后选择增加参数EdgeColor边颜色，为r（red）


% 求出任意两点之间的距离，返回一个距离矩阵
% help distances: 此 MATLAB 函数 返回矩阵 d，其中 d(i,j) 是节点 i 和节点 j 之间的最短路径的长度。
% 如果图进行了加权（即 G.Edges 包含变量Weight），则这些权重用作沿图中各边的距离。否则，所有边距离都视为 1。
% distances(graph)函数， 参数为图对象
% 其中dij 就表示i到j的距离
D = distances(G) 
D(1, 2) % 表示从1到2最短的距离为6

% 找出给定范围内所有的点: nearest(G, s, d)
% 返回图G中, 与节点s的距离在d内的所有节点, 相当于以s节点为中心
% 返回的第一个参数为节点编号， 第二个参数到节点的距离
[nodeIDs, dist] = nearest(G, 2, 10)


