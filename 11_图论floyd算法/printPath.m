% 打印从start到end经过的节点序号
% dist是最短距离
% path是路径矩阵
% start是起点
% end是终点

function [] = printPath(dist, path, startnode, endnode)
	% 判断输入是否正确, 
	if startnode == endnode % 其实节点与
		warning('start and end coherence') % 在屏幕中提示warning信息
		disp('起始与结束节点一致,错误')
		return; % 直接退出函数
	end
	
	if path(i,j) == j % 如果距离等于当前列号(j),有两种可能
		if dist(i,j) == Inf % 等于无穷,说明没有路径可以到达
			disp([num2str(i), '到', num2str(j),'没有路径可以到达']);
		else % 等于它本身,且不是Inf,则说明直接到达
			disp(['从', num2str(i), '到', num2str(j), '之间的最短路径'])
			disp([num2str(i), '->', num2str(j)])
			disp(['最短距离为', num2str(dist(i, j))])
		end
	
	else % pash(i,j) ~= j:若该位置不等于该列号,说明中间经过其他节点
		k = path(i,j);
		result = [num2str(i),'->']; % 初始节点
		
		while k ~= j % k不等于j, 就说明没找到最终节点
			result = [result, num2str(k),'->']; % 迭代向量
			k = path(k,j); % 替换i,k
		end
		
		result = [result , num2str(k)];
		
		disp(['从', num2str(i), '到', num2str(j), '之间的最短路径'])
		disp(result)
		disp(['最短距离为', num2str(dist(i, j))])
		
	
	end


end