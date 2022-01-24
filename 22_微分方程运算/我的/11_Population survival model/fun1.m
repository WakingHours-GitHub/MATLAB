% 情况1: 甲可以独立生存, 但是乙不能独立生存
% 这里假设甲, 乙都服从logistic模型, 
% 并且甲可以独立生存所以甲是生长率, 而乙需要依靠甲来生存所以我们认为乙是存在固有生长率
function dx = fun1(t, x)
    % 模型参数:
    % 甲, 乙的增长率和死亡率(死亡率我们用-的增长率来描述)
    r1 = 0.5; r2 = 0.5;
    % 甲, 乙的最大数量
    N1 = 300; N2 = 500;
    % sigma1: 单位数量的乙种群(相对于N2)提供的供养甲的食物量为单位数量的甲(相对于N1)消耗的供养甲的食物量的倍数。
    % sigma2: 单位数量的甲种群(相对于N1)提供的供养乙的食物量为单位数量的乙(相对于N2)消耗的供养乙的食物量的倍数。
    sigma1 = 0.2; sigma2 = 2;
       
    % 微分方程组
    dx = zeros(2, 1);
    dx(1) = r1*x(1) * (1-x(1)/N1 + sigma1*x(2)/N2);
    dx(2) = r2*x(2) * (-1 -x(2)/N2 + sigma2*x(1)/N1);
end