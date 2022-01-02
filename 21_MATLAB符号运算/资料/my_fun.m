function F = my_fun(x)
    % x表示自变量的个数，X(i)就要表示各个自变量
    % F表示方程矩阵，F(i) 就表示每个方程
    F(1) = exp(-exp(-(x(1)+x(2)))) - x(2)*(1+x(1)^2);
    F(2) = x(1)*cos(x(2)) + x(2)*sin(x(1)) - 0.5;
end