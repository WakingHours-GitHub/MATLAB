%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPML110
% Project Title: Implementation of DBSCAN Clustering in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
%
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
%
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

% DBSCAN聚类算法:
% 是基于密度的聚类方法，不需要事先指定K(类别数), 生成的簇数不定(和数据相关)
% 受eps和minpoints影响较大.

% 返回的IDX是类别
function [IDX, isnoise]=DBSCAN(X,epsilon,MinPts)

C=0;

n=size(X,1); % 对行操作, 数列
IDX=zeros(n,1);  % 初始化全部为0，即全部为噪音点

D=pdist2(X,X); % 两组观测之间的成对距离, 默认使用欧式距离


visited=false(n,1); % 访问数组
isnoise=false(n,1);

for i=1:n
	if ~visited(i) % 如果没有访问
		visited(i)=true; % 标记访问
		
		% 计算邻接节点
		Neighbors=RegionQuery(i);
		if numel(Neighbors)<MinPts % 邻接节点
			% X(i,:) is NOISE
			isnoise(i)=true;
		else
			C=C+1;
			ExpandCluster(i,Neighbors,C);
		end
		
	end
	
end

	function ExpandCluster(i,Neighbors,C)
		IDX(i)=C;
		
		k = 1;
		while true
			j = Neighbors(k);
			
			if ~visited(j)
				visited(j)=true;
				Neighbors2=RegionQuery(j);
				if numel(Neighbors2)>=MinPts
					Neighbors=[Neighbors Neighbors2];   %#ok
				end
			end
			if IDX(j)==0
				IDX(j)=C;
			end
			
			k = k + 1;
			if k > numel(Neighbors)
				break;
			end
		end
	end

	% 找邻接节点, 中心画园
	function Neighbors=RegionQuery(i)
		Neighbors=find(D(i,:)<=epsilon);
	end

end



