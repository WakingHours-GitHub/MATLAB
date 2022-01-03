function [x0_hat, relative_residuals, eta] = coefficient(x0)
    % 计算系数
    
    n = length(x0); % 
    x1=cumsum(x0); % 计算一次累加值
    z1 = (x1(1:end-1) + x1(2:end)) / 2;  % 计算紧邻均值生成数列（长度为n-1） -> 相邻的x1求平均值
    % 将从第二项开始的x0当成y，z1当成x，来进行一元回归  y = kx +b
    y = x0(2:end); % -> 要从2项开始取
    x = z1; 
    
    k = ((n-1)*sum(x.*y)-sum(x)*sum(y))/((n-1)*sum(x.*x)-sum(x)*sum(x));
    b = (sum(x.*x)*sum(y)-sum(x)*sum(x.*y))/((n-1)*sum(x.*x)-sum(x)*sum(x));
    a = -k;  %注意：k = -a哦 -> 发展系数
    % 计算拟合值
    x0_hat=zeros(n,1);  x0_hat(1)=x0(1);   % x0_hat向量用来存储对x0序列的拟合值，这里先进行初始化
    for m = 1: n-1
        x0_hat(m+1) = (1-exp(a))*(x0(1)-b/a)*exp(-a*m);
    end
    % 计算绝对残差和相对残差
    absolute_residuals = x0(2:end) - x0_hat(2:end);   % 从第二项开始计算绝对残差，因为第一项是相同的
    relative_residuals = abs(absolute_residuals) ./ x0(2:end);  % 计算相对残差，注意分子要加绝对值，而且要使用点除
    % 计算级比 和 级比偏差
    class_ratio = x0(2:end) ./ x0(1:end-1) ;  % 计算级比 sigma(k) = x0(k)/x0(k-1)
    eta = abs(1-(1-0.5*a)/(1+0.5*a)*(1./class_ratio));  % 计算级比偏差 1 - ... (一大堆数学公式)


end
