%% MATLAB实现灰色预测模型
clear;clc
%% 数据：
year =[1995:1:2004]';  % 横坐标表示年份，写成列向量的形式（加'就表示转置）
x0 = [174,179,183,189,207,234,220.5,256,270,285]';  %原始数据序列，写成列向量的形式（加'就表示转置）


%% 开始建立预测模型模型
% 画出时间序列图：  
figure(1); % 标号
plot(year, x0, 'o-');
title("时间序列图");
grid on; % 画出网格线
set(gca, 'xtick', year(1: 1: end)) % 设置x横轴的坐标间隔为1
xlabel('年份'); ylabel('排污总量'); % 加标签

% 然后使用GM(1,1)模型 -> 适用于数据期数较短的非负的时间序列
isError = 0; % 创建一个flag, 用于指出是否出错

% 判断是否含有负数数据
if sum(x0 < 0 ) > 0
	disp("存在负数数据, 灰色预测的时间序列中不能存在负数")
	isError = 1; % 错误指标
end

% 判断是否数据量太少
n = length(x0) % 求取长度
disp(strcat('数据长度为: ', num2str(n)))
if n < 4
	disp("数据量过于小, 无法建立灰色预测模型");
	isError = 1;
end

% 数据太多的时候:
if n > 10
	disp('您的数据量过多, 可以使用其他模型, 例如ARIMA模型或者指数平滑模型');
	% 但是这里不报错, 程序可以继续进行
end

% 判断矩阵是否为列向量, 若输入的是行向量, 则自动转置成为列向量
if size(x0, 1) == 1 % 此时行数=1 -> 说明是行向量
	x0 = x0'; % 转置
end
% 对年份也同样进行该操作
if size(year, 1) == 1
	year = year';
end

%% 上面是对数据进行预处理, 下面我我们对数据进行准指数检验
%% 下面开始对数据准指数检验
if isError == 0
	disp("-----------------------------------------------------------");
    disp("下面开始对数据进行准指数检验");
    x1 = cumsum(x0); % 对x0累加得到x1
    rho = x0(2: end) ./ x1(1: end-1); % 计算光滑度
    % 画出光滑度的图形
    figure(2)
    plot(year(2: end), rho, 'o-', [year(2), year(end)], [0.5, 0.5], '-');
    title('光滑度趋势');
    % 画出rho的趋势, 然后画出参考线0.5
    grid on;
    text(year(end-1)+0.2, 0.55, '临界线') % put text 打标签
    set(gca, 'xtick', year(2: 1: end)) % 设置坐标轴
    xlabel("年份"); ylabel("原始数据光滑度");
    % 看光滑度可以 -> 得出看曲线拟合情况

    % 然后计算满足条件数据的占比
    disp(strcat('指标1: 光滑比小于0.5的数据占比为',num2str(100*sum(rho<0.5)/(n-1)),'%')) % 百分比 (因为x1是1-k-1所以应该是n-1个总俗话)
    disp(strcat('指标2: 除去前两个时期外，光滑比小于0.5的数据占比为',num2str(100*sum(rho(3:end)<0.5)/(n-3)),'%')) % 除去前两个时期 -> 所以从3开始
    disp("参考指标: 指标1要>60%, 指标2要>90%, 所以你认为本数据是否通过准指数检验?")

    disp("是否通过准指数检验?, 输入1,表示可以通过, 0表示不可以通过");
    judge = input("input:");
    
    if judge == 0
        disp("不通过, 程序结束, 请更换其他模型.")
        isError = 1; % 标志不通过
    else
        disp("准指数检验通过，可以进行后续的步骤");
    end
    
    disp("准指数检验结束")
    disp("-------------------------------")
end
% 上面就是准指数检验的过程.

%% 下面开始进行灰色预测模型预测
%% 当数据量>4的时，我们利用试验组来选择使用传统的GM（1，1）模型，新信息GM（1，1）模型还是新陈代谢GM（1，1）模型
%% 如果数据量=4，我们直接对三种模型求一个平均来预测。 （因为数据量小，所以预测多数都相同）

if isError == 0 % 表示没有发生错误
    % 分配试验组和训练组
    if n > 4
        disp('数据量>4，所以我们将数据分为训练组和试验组');
        if n < 7 % 数据量<7，试验组为2组
            test_num = 2; % 设置试验组组数 2
        else
            test_num = 3;
        end
        test_x0 =  x0(end-test_num+1:end); % 试验组数据
        train_x0 = x0(1: end-test_num); % 那么训练组就是总组-试验组
        
        % 打印分组结果
         % mat2str可以将矩阵或者向量转换为字符串显示, 这里加一撇表示转置，把列向量变成行向量方便观看
        disp('训练的数据'); disp(mat2str(train_x0'));

        disp('试验数据是: '); disp(mat2str(test_x0'))  % mat2str可以将矩阵或者向量转换为字符串显示
        disp('-------------------------------------------------------------------------------')
        
        % 使用三种模型对训练数据进行训练，返回的result就是往后预测test_num期的数据
        % 函数名(原始数据, 预测的期数) 预测的期数实际上就是试验组的个数 -> 因为试验组的数据已知, 所以我么需要使用训练组然后对试验组进行预测
        disp("使用传统GM(1, 1)预测的过程: ");
        result1 = gm11(train_x0, test_num); %使用传统的GM(1,1)模型对训练数据，并预测后test_num期的结果
        
        disp("使用新信息GM(1, 1)预测的过程: ");
        result2 = new_gm11(train_x0, test_num);
        
        disp("使用新陈代谢GM(1, 1)预测的过程: ");
        result3 = metabolism_gm11(train_x0, test_num);
        
        
        
        % 比较三种模型对于试验组的预测
        disp("预测结束, 比较三种模型对试验数据据的预测结果: ");
        % 绘制对试验数据进行预测的图形(对于部分数据, 可能是三条直线预测的结果非常接近)
        figure(3);
        test_year = year(end-test_num+1:end); % 表示预测组的年份, 画图用 (express predect year, plot use)
         % end是一种预设值
        plot(test_year, test_x0, 'o-r',test_year, result1, '*-b', test_year, result2, '+-g', test_year, result3, 'x-k');        
        xlabel('年份'); ylabel('排污总量'); %%% 这里要改
        title('三种模型的预测');
        legend('原始真实数据','传统GM(1,1)模型','新信息GM(1,1)模型','新陈代谢GM(1,1)模型', 'Location','northwest')
        
        
        % 计算误差平方和SSE, 选择SSE最小的那个模型来作为整体的模型
        SSE1 = sum((test_x0-result1).^2);
        SSE2 = sum((test_x0-result2).^2);
        SSE3 = sum((test_x0-result3).^2);
        disp(strcat('传统GM(1,1)对于试验组预测的误差平方和为',num2str(SSE1)))
        disp(strcat('新信息GM(1,1)对于试验组预测的误差平方和为',num2str(SSE2)))
        disp(strcat('新陈代谢GM(1,1)对于试验组预测的误差平方和为',num2str(SSE3)))
        % 显然, SSE接近的图像, 在图像上也接近, 
        % SSE越小, 则代表图像拟合的越好
        all_solution = [SSE1 SSE2 SSE3];
        model = {'传统GM(1,1)模型','新信息GM(1,1)模型','新陈代谢GM(1,1)模型'};
        logical_location = all_solution == min(all_solution);
        % find()查找非零元素的索引和数值
        best_solution = find(logical_location);
        disp(strcat(model(best_solution),'的SSE最小,为:',num2str(all_solution(best_solution)), ',于是我们选择该模型'));
        
        
        
        
        % 选择用SSE最小的那个模型进行预测
        
          
        
    else % n <= 4 只有四期数据吗， 那么我们就没必要选择何种模型进行预测，
         % 因为三种模型的预测结果都差不多，所以我们直接对三种模型的预测求一个平均值
        
        
    end
    
end









































































