function [weigh] = Entropy_Method(Z)
	%% 计算熵权
	[n, m] = size(Z)
	D = zeros(1, m);
	for i = 1 : m
		x = Z(:, i);
		p = x / sum(x);
		e = -sum(p.*myLog(p)) / log(n);
		D(i) = 1 - e; % 计算信息效用数值
	end

	weigh = D ./ sum(D); % 将信息效用值归一化,得到权重


end