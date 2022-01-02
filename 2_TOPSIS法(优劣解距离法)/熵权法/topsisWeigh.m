%% topsis优劣解距离法
%% 使用赋权法获得权重


clear;clc
load data_water_quality.mat % X
load X_name % X_name

[n, m] = size(X)
disp([ '共有' num2str(n) '个评价对象, ' num2str(m) '个评价指标'])

%% 判断是否需要指标正向话
Judge = input(['这' num2str(m) '个评价指标是否需要正向化? (1需要，0不需要）'])

if Judge == 1 % 需要正向化的列标号
    
    disp(X_name(1,:)) 
    fprintf("哪一列需要正向化：\n ")
    Position = input("请用矩阵形式[ ]输入:") % 需要正向化的列标号
    fprintf("请分别输入这几列是哪种指标类型\n 1为极小型，2为中间型，3为区间型\n")
    
    Type = input("用矩阵[]输入"); % 输入这几列的指标类型
    
    % 这里还需要加入一个说明性语句
    
    for i = 1 : size(Position, 2)  % 对非极大型指标，指标正向化
        X(:, Position(i)) = Positivization(X(:,Position( i)), Type(i), Position(i)); 
         
    end
    disp('正向化后的矩阵')
    disp(X)
    
else
    disp('不需要正向化')

end


%% 对正向化后的矩阵进行标准化(标准化公式在pdf里)
Z = X ./ repmat(sum(X.*X) .^ 0.5, n, 1); 
disp('标准化的矩阵 Z = ')
disp(Z)

%% 判断是否需要增加权重
disp('是否需要增加权重(1: 需要, 0: 不需要):')
judge = input(''); 
if judge == 1 % 需要加权重
isOk = 0 % 判断weigh权重输入是否正确
	judge = input('是否使用熵权法确定权重(1 使用, 2 不使用)')
	if judge == 1 %% 使用熵权法获得权重
		disp('熵权法获得权重')
		% 对矩阵进行标准化(若原标准化得到的Z的矩阵中存在负数, 所以需要对x重新标准化)
		if sum(sum(X < 0)) > 0 % 矩阵中存在负数
			disp('原矩阵存在负数,所以重新标准化')
			% 标准化(公式在pdf里)
			for i = 1 : n
				for j = 1 : m
					Z(i,j) = (X(i,j) - min(x(:,j)))/  max(X(:, j)) - min(X(:,j));
				end
				
			end

		end
		% 标准化后的矩阵
		weigh = Entropy_Method(Z); % 调用确定熵权法的权重的函数
		disp('熵权法确定的权重: ')
		disp(weigh)
		
		isOk = 1 % 不用手动输入
	else
		disp('手工输入各个列的权重')
		%isOk = 0
		
	end
	
	
	while isOk == 0
		disp('请输入与衡量指标同阶的权重矩阵, 他们相加必须为1')
		weigh = input(['共有' num2str(m) '评价指标, 所以需要1*' num2str(m) '的权重矩阵'])
		
		if (abs(sum(weigh)-1 <= 1e-8)) && (size(weigh, 2) == m && size(weigh,1) == 1) % 这里weigh加出来得到一个浮点数，所以不能用整形比较方式
			isOk = 1;	
			disp('输入正确')
		else
			disp('输入不正确请重新输入')
	
		end 
	
	end

else % 不需要权重的情况
	% 此时weigh是一个列向量，所以用下面这种方式[实例化]

	weigh = ones(1, m) ./ m; % 若不需要权重，则默认取均值
    
end


%% 第四步：计算与最大值的距离和最小值的距离，并算出得分


D_P = sum([(Z - repmat(max(Z),n,1)) .^ 2 ] .* repmat(weigh,n,1) ,2) .^ 0.5;   % D+ 与最大值的距离向量
D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ] .* repmat(weigh,n,1) ,2) .^ 0.5;   % D- 与最小值的距离向量
S = D_N ./ (D_P+D_N);    % 未归一化的得分
% 标准化：
stand_s = S / sum(S)
[sorted_S, index] = sort(stand_s,'descend')