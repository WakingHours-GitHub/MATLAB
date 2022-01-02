% 该函数是使用Floyed算法, 求解任意两个节点之间的距离与路径
% Floyd算法运行一次，返回所有节点之间的距离和路径

% 参数列表: D: adjacent matrix 邻接矩阵
% 输出:
% 		dist: 最短距离矩阵, dij表示i到j的最短距离
%		path: 路径矩阵, pij表示i到j之间的经过节点序列
% adjacent matrix

function [dist, path] = Floyd(D)
    n = size(D, 1) % 计算有多少行
    dist = D; % 初始化

    path = zeros(n); % 初始化n阶0矩阵
    for j = 1:n
        path(:, j) = j;
    end
    for i = 1:n
        path(i, i) = -1;
    end

    % Folyd算法核心: 三个循环
    for k = 1 : n % 中间节点k从1-n循环
        for i = 1 : n % 起始节点i从1到1-n循环
            for j = 1 : n % 末尾节点j从1-n循环
                % 若i,j个节点的最短距离大于i和k的最短距离 + k和j的最短距离
                if dist(i,j) > dist(i,k) + dist(k,j)
                    % 更新dist和path矩阵
                    dist(i,j) = dist(i,k) + dist(k,j)
                    path(i,j) = path(i,k);
                end
            end
        end
    end
    
end