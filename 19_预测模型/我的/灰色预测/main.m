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
        disp("----------------------------------")
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
        % find()查找第一个非零元素的索引和数值
        best_solution = find(logical_location);
        disp("显然:");
        disp(strcat(model(best_solution),'的SSE最小,为:',num2str(all_solution(best_solution)), ',于是我们选择该模型'));
        
        % 选择用SSE最小的那个模型进行预测
        predict_num = input("请输入要预测的期数: "); % 接受预测期数
        % 计算各种系数(用GM（1,1)模型)
%         [result, x0_hat, relative_residuals, eta] = gm11(x0, predict_num) % 计算系数
        [x0_hat, relative_residuals, eta] = coefficient(x0); % 计算系数
        
        % 我们选择用SSE最小的那个模型计算
        if best_solution == 1 % 使用传统gm11模型进行预测
            result = gm11(x0, predict_num);
        elseif best_solution == 2 % 使用新信息gm11进行预测
            result = new_gm11(x0, predict_num);
        elseif best_solution == 3 % 使用新陈代谢gm11模型进行预测
            result = metabolism_gm11(x0, predict_num);
        else
            disp("出错");
        end
        
        % 输出使用最佳的模型预测出来的结果: % 这个有可以改
        disp("=================================================================");
        disp("对原始数据的拟合结果");
        for i = 1:n
            disp(strcat(num2str(year(i)), ' ： ',num2str(x0_hat(i))))
        end
        % 后期预测的结果
        disp(strcat('往后预测',num2str(predict_num),'期的得到的结果：'))
        for i = 1:predict_num
            disp(strcat(num2str(year(end)+i), ' ： ',num2str(result(i))))
        end
        
        
        
          
        
    else % n <= 4 只有四期数据吗， 那么我们就没必要选择何种模型进行预测，
         % 因为三种模型的预测结果都差不多，所以我们直接对三种模型的预测求一个平均值
        disp("数据量期数较小, 因此我们直接使用三种方法的结果求取平均值即可")
        predict_num = input('请输入你要往后面预测的期数： ');
                 disp(' ')
         disp('***下面是传统的GM(1,1)模型预测的详细过程***')
        [result1, x0_hat, relative_residuals, eta] = gm11(x0, predict_num);
        disp(' ')
        disp('***下面是进行新信息的GM(1,1)模型预测的详细过程***')
        result2 = new_gm11(x0, predict_num);
        disp(' ')
        disp('***下面是进行新陈代谢的GM(1,1)模型预测的详细过程***')
        result3 = metabolism_gm11(x0, predict_num);
        % 对结果计算平均值
        result = (result1+result2+result3)/3;
                disp('对原始数据的拟合结果：')
        for i = 1:n
            disp(strcat(num2str(year(i)), ' ： ',num2str(x0_hat(i))))
        end
        disp(strcat('传统GM(1,1)往后预测',num2str(predict_num),'期的得到的结果：'))
        for i = 1:predict_num
            disp(strcat(num2str(year(end)+i), ' ： ',num2str(result1(i))))
        end
        disp(strcat('新信息GM(1,1)往后预测',num2str(predict_num),'期的得到的结果：'))
        for i = 1:predict_num
            disp(strcat(num2str(year(end)+i), ' ： ',num2str(result2(i))))
        end
        disp(strcat('新陈代谢GM(1,1)往后预测',num2str(predict_num),'期的得到的结果：'))
        for i = 1:predict_num
            disp(strcat(num2str(year(end)+i), ' ： ',num2str(result3(i))))
        end
        disp(strcat('三种方法求平均得到的往后预测',num2str(predict_num),'期的得到的结果：'))
        for i = 1:predict_num
            disp(strcat(num2str(year(end)+i), ' ： ',num2str(result(i))))
        end
    end % 结果计算决策
    
    %% 绘制相对残差和级比偏差的图形(注意：因为是对原始数据的拟合效果评估吗, 所以三个模型计算得到的参数是一样的)
    %% 所以这里仅仅用coefficient()函数进行参数计算
    figure(4);
    subplot(2,1,1)  % 绘制子图（将图分块）
    plot(year(2:end), relative_residuals,'*-'); grid on;   % 原数据中的各时期和相对残差
    legend('相对残差'); xlabel('年份');
    set(gca,'xtick',year(2:1:end))  % 设置x轴横坐标的间隔为1
    subplot(2,1,2)
    plot(year(2:end), eta,'o-'); grid on;   % 原数据中的各时期和级比偏差
    legend('级比偏差'); xlabel('年份');
    set(gca,'xtick',year(2:1:end))  % 设置x轴横坐标的间隔为1
    disp(' ')
    disp('====下面将输出对原数据拟合的评价结果====')
    
    %% 残差检验
    average_relative_residuals = mean(relative_residuals);  % 计算平均相对残差 mean函数用来均值
    disp(strcat('平均相对残差为',num2str(average_relative_residuals)))
    if average_relative_residuals<0.1
        disp('残差检验的结果表明：该模型对原数据的拟合程度非常不错')
    elseif average_relative_residuals<0.2
        disp('残差检验的结果表明：该模型对原数据的拟合程度达到一般要求')
    else
        disp('残差检验的结果表明：该模型对原数据的拟合程度不太好，建议使用其他模型预测')
    end
    
    %% 级比偏差检验
    average_eta = mean(eta);   % 计算平均级比偏差
    disp(strcat('平均级比偏差为',num2str(average_eta)))
    if average_eta<0.1
        disp('级比偏差检验的结果表明：该模型对原数据的拟合程度非常不错')
    elseif average_eta<0.2
        disp('级比偏差检验的结果表明：该模型对原数据的拟合程度达到一般要求')
    else
        disp('级比偏差检验的结果表明：该模型对原数据的拟合程度不太好，建议使用其他模型预测')
    end
    disp(' ')
    disp('------------------------------------------------------------')
    
    %% 绘制最终的预测效果图
    figure(5)  % 下面绘图中的符号m:洋红色 b:蓝色
    title("原始图像和预测图像");
    plot(year,x0,'-o',  year,x0_hat,'-*m',  year(end)+1:year(end)+predict_num,result,'-*b' );   grid on;
    hold on;
    plot([year(end),year(end)+1],[x0(end),result(1)],'-*b')
    legend('原始数据','拟合数据','预测数据')  % 注意：如果lengend挡着了图形中的直线，那么lengend的位置可以自己手动拖动
    set(gca,'xtick',[year(1):1:year(end)+predict_num]);  % 设置x轴横坐标的间隔为1 % 这里的1也是可以修改的. 可以修改间隔,看起来更好看一些,
    xlabel('年份');  ylabel('排污总量');  % 给坐标轴加上标签, 这个地方要改
end % 结束
