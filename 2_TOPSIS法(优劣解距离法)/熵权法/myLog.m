function [lnx] = myLog(x)
	n = length(x) % ���������ĳ���
	lnx = zeros(n,1);
	for i = 1 : n
		if x(i) == 0
			lnx(i) = 0;
		else
			lnx(i) = log(x(i));
		end
	end
end