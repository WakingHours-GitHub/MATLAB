% ��ӡ��start��end�����Ľڵ����
% dist����̾���
% path��·������
% start�����
% end���յ�

function [] = printPath(dist, path, startnode, endnode)
	% �ж������Ƿ���ȷ, 
	if startnode == endnode % ��ʵ�ڵ���
		warning('start and end coherence') % ����Ļ����ʾwarning��Ϣ
		disp('��ʼ������ڵ�һ��,����')
		return; % ֱ���˳�����
	end
	
	if path(i,j) == j % ���������ڵ�ǰ�к�(j),�����ֿ���
		if dist(i,j) == Inf % ��������,˵��û��·�����Ե���
			disp([num2str(i), '��', num2str(j),'û��·�����Ե���']);
		else % ����������,�Ҳ���Inf,��˵��ֱ�ӵ���
			disp(['��', num2str(i), '��', num2str(j), '֮������·��'])
			disp([num2str(i), '->', num2str(j)])
			disp(['��̾���Ϊ', num2str(dist(i, j))])
		end
	
	else % pash(i,j) ~= j:����λ�ò����ڸ��к�,˵���м侭�������ڵ�
		k = path(i,j);
		result = [num2str(i),'->']; % ��ʼ�ڵ�
		
		while k ~= j % k������j, ��˵��û�ҵ����սڵ�
			result = [result, num2str(k),'->']; % ��������
			k = path(k,j); % �滻i,k
		end
		
		result = [result , num2str(k)];
		
		disp(['��', num2str(i), '��', num2str(j), '֮������·��'])
		disp(result)
		disp(['��̾���Ϊ', num2str(dist(i, j))])
		
	
	end


end