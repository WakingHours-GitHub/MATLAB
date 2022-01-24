function dx = dx(t, x)
% myFun - Description
%
% Syntax: dx = myFun(t, x)
%
% Long description

% param seetings:
% 参数是可以修改的, 根据具体问题
% 甲 乙的增长率：
r1 = 0.5; r2 = 0.5;
% 甲 乙种群的最大数量
N1 = 300; N2 = 500;
% sigma1: 单位数量的乙种群(相对于N2)消耗的供养甲的食物量为单位数量的甲(相对于N1)消耗的供养甲的食物量的倍数。
% sigma2: 单位数量的甲种群(相对于N1)消耗的供养乙的食物量为单位数量的乙(相对于N2)消耗的供养乙的食物量的倍数。
sigma1 = 0.5; sigma2 = 2;

% 微分方程组:
dx = zeros(2, 1); % 初始化变量
dx(1) = r1*x(1) * (1-x(1)/N1 - sigma1*x(2)/N2);
dx(2) = r2*x(2) * (1-x(2)/N1 - sigma2*x(1)/N2);




end