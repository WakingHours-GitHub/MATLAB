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

% DBSCAN�����㷨:
% �ǻ����ܶȵľ��෽��������Ҫ����ָ��K(�����), ���ɵĴ�������(���������)
% ��eps��minpointsӰ��ϴ�.

% ���ص�IDX�����
function [IDX, isnoise]=DBSCAN(X,epsilon,MinPts)

C=0;

n=size(X,1); % ���в���, ����
IDX=zeros(n,1);  % ��ʼ��ȫ��Ϊ0����ȫ��Ϊ������

D=pdist2(X,X); % ����۲�֮��ĳɶԾ���, Ĭ��ʹ��ŷʽ����


visited=false(n,1); % ��������
isnoise=false(n,1);

for i=1:n
	if ~visited(i) % ���û�з���
		visited(i)=true; % ��Ƿ���
		
		% �����ڽӽڵ�
		Neighbors=RegionQuery(i);
		if numel(Neighbors)<MinPts % �ڽӽڵ�
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

	% ���ڽӽڵ�, ���Ļ�԰
	function Neighbors=RegionQuery(i)
		Neighbors=find(D(i,:)<=epsilon);
	end

end



