% function [result, x0_hat, relative_residuals, eta] = gm11(x0, predict_num)
function [result] = gm11(x0, predict_num)
    % function: use traditional GM(1,1) model to predict
    % params:
    %   x0: source data
    %   predict_num: Predict periods
    % out put:
    %   result: predict result
    %   x0_hat: source data fitting values
    %   relative_residuals: 相对残差
    %   eta: 对模型进行评价时得到的级比偏差
    n = length(x0); % 计算原始数据的长度
    x1 = cumsum(x0); % 计算一次累加和
    z1 = (x1(1:end-1) + x1(2:end)) / 2; % 计算近邻均值生成数列.-> 相邻的x1求平均值
    % 从第二项开始的x0当成y, z1当成x, 来进行一次回归 y = kx + b
    y = x0(2:end);
    x = z1;
    
    % 参数估计(最小二乘法:OSL法)
    k_hat = ((n-1) * sum(x.*y) - sum(x) * sum(y)) / ((n-1) * sum(x.*x) - sum(x) * sum(x));
    b_hat = (sum(x.*x) * sum(y) - sum(x) * sum(x.*y)) / ((n-1) * sum(x.*x) - sum(x)*sum(x));
    a = -k_hat; % a = -k, 为发展系数
    
    disp('现在进行GM(1, 1)预测的数据: ');
    disp(mat2str(x0')); % mat2str可以转换将矩或向量 转换成为字符串
    disp(['OSL估计得到的发展系数为-a: ', num2str(-a), '灰总用量b为: ', num2str(b_hat)]);

    result = zeros(predict_num, 1); % 初始化列向量, 用于后续保存预测的数据
    for i = 1: predict_num
        result(i) = (1-exp(a))*(x0(1)-b_hat/a)*exp(-a*(n+i-1)); % 带入公式直接计算
    end
    
%     % 计算输出参数 compute output parms
%     x0_hat = zeros(n, 1); % x0_hat向量用来存储对x0序列的拟合值，这里先进行初始化
%     
%     x0_hat(1) = x0(1); % 第一组数据
%     for m = 1: n-1
%        x0_hat(m+1) = (1-exp(a))*(x0(1)-b_hat/a)*exp(-a*m); % 计算得到
%     end
    

    
%     % 计算绝对残差和相对残差
%     absolute_residuals = x0(2:end) - x0_hat(2:end);   % 从第二项开始计算绝对残差，因为第一项是相同的
%     relative_residuals = abs(absolute_residuals) ./ x0(2:end);  % 计算相对残差，注意分子要加绝对值，
%     % 计算级比 和 级比偏差
%     class_ratio = x0(2:end) ./ x0(1:end-1) ;  % 计算级比 sigma(k) = x0(k)/x0(k-1)
%     eta = abs(1-(1-0.5*a)/(1+0.5*a)*(1./class_ratio));  % 计算级比偏差 1 - ... (一大堆数学公式)
%     
%     % 计算这么多参数为了返回到main函数中,可以进行说明与检验.
    
    
end