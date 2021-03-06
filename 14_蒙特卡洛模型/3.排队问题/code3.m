%% 蒙特卡洛模拟排队论问题


%% 预备知识
% normrnd(MU, SIGMA): 生成一个服从正态分布（MU:均值, SIGMA参数代表标准差, 方差开根号是标准差)的随机数
normrnd(10,2) % 生成均值为10,标准差为2(方差为4)的正态分布随机数
% exprnd(M) % 表示生成均值为M(Ex = M)的指数分布随机数(其对应参数λ为:1/M(λ = 1/Ex))
exprnd(5) % 
% mean(矩阵,dim): 表示对矩阵行或者列求均值,dim = 1表示对列操作,返回行向量,dim = 2表示对行操作,返回列向量
mean([1 2 3]) 
% tic和toc函数,可以用来返回代码的运行时间,
% tic: 启动秒表计时器
% toc: 读取秒表计时器
tic
% 需要测量时间的代码
toc

%% 排队论问题的代码书写:


%% 问题描述:
% 假设某银⾏⼯作时间只有⼀个服务窗⼝，⼯作⼈员只能逐个的接待顾客。
% 当来的顾客较多时，⼀部分顾客就需要排队等待。
% 假设：
% 1) 顾客到来的间隔时间服从参数为0.1的指数分布(exp,λ为0.1, Ex = 10)
% 2) 每个顾客的服务时间服从均值为10，⽅差为4的正态分布(norm)(单位为分钟，若服务时间⼩于1分钟，则按1分钟计算) 
% 3) 排队按先到先服务的规则，
% 且不限制队伍的⻓度，每天⼯作时⻓为8⼩时。8 * 60 = 480 分钟
% 试回答下⾯的问题：
% 1) 模拟⼀个⼯作⽇，在这个⼯作⽇共接待了多少客户，客户平均等待的时间为多少? 
% 2) 模拟100个⼯作⽇，计算出平均每⽇接待客户的个数以及每⽇客户的平均等待时⻓

%% 模型中出现的变量说明

% x(i)表示第i-1个客户和第i个客户到达的间隔时间，服从参数为0.1的指数分布
% y(i)表示第i个客户的服务持续时间，服从均值为10方差为4(标准差为2)的正态分布 (若小于1则按1计算)
% c(i)表示第i个客户的到达时间，那么c(i) = c(i-1) + x(i)，初始值c0=0
% b(i)表示第i个客户开始服务的时间
% e(i)表示第i个客户结束服务的时间，初始值e0=0

% 推导的关系:
% 第i个客户结束服务的时间 = 第i个客户开始服务的时间 + 第i个客户的服务持续时间
% 即：e(i) = b(i) + y(i）
% 第i个客户开始服务的时间取决于该客户的到达时间和上一个客户结束服务的时间
% 即：b(i) = max( c(i), e(i-1) )，初始值b1 = c1;
% 第i个客户等待的时间 = 第i个客户开始服务的时间 - 第i个客户到达银行的时间
% 即：wait(i) = b(i) - c(i)
% w表示所有客户等待时间的总和
% 假设一天内银行最终服务了n个顾客，那么客户的平均等待时间t = w/n

%% 开始书写代码
clear;clc
tic % 打开计时器
i = 1; % 人,第i个人
w = 0; % 表示总的等待时间
e0 = 0; c0 = 0; % 初始化: 到达,结束服务时间均为0
 
x(1) = exprnd(10); % 生成第1个人来的间隔
c(1) = c0 + x(1); % 生成第一个到达的时间,表示第0个人到的时间和第1一个人间隔之和
b(1) = c(1); % 因为是第一个来了,所以开始服务就是到达时间

while b(i) <= 480 % 一天8小时, 换算分钟:480分钟
    % 随机模拟服务持续时间
    y(i) = normrnd(10,2); 
    if y(i) < 1
        y(i) = 1;
    end
    
    % 服务结束时间 = 开始服务 + 服务持续
    e(i) = b(i) + y(i);
    % 等待时间 = 开始服务 - 到达时间
    wait(i) = b(i) - c(i);
    w = w + wait(i); % 总时间叠加
    i = i + 1; % 增加新的用户
    x(i) = exprnd(10); % 为新用户和上个用户生成间隔
    c(i) = c(i - 1) + x(i); % 迭代
    b(i) = max(c(i), e(i-1)); % 开始服务时间 = =max(i到达时间, 上个人服务结束时间)
    
end
n = i - 1;
t = w / n;
disp(['银行一天8小时(480分钟)一共服务的客户人数为:', num2str(n)])
disp(['平均等待时间:', num2str(t)])
toc

%% 一百次蒙特卡洛模拟
clear;  clc
tic
day = 100;
n = zeros(day, 1);
t = zeros(day, 1);
for k = 1:day
    
    i = 1; % 人,第i个人
    w = 0; % 表示总的等待时间
    e0 = 0; c0 = 0; % 初始化: 到达,结束服务时间均为0
     
    x(1) = exprnd(10); % 生成第1个人来的间隔
    c(1) = c0 + x(1); % 生成第一个到达的时间,表示第0个人到的时间和第1一个人间隔之和
    b(1) = c(1); % 因为是第一个来了,所以开始服务就是到达时间

    while b(i) <= 480 % 一天8小时, 换算分钟:480分钟
        % 随机模拟服务持续时间
        y(i) = normrnd(10,2); 
        if y(i) < 1
            y(i) = 1;
        end
        
        % 服务结束时间 = 开始服务 + 服务持续
        e(i) = b(i) + y(i);
        % 等待时间 = 开始服务 - 到达时间
        wait(i) = b(i) - c(i);
        w = w + wait(i); % 总时间叠加
        i = i + 1; % 增加新的用户
        x(i) = exprnd(10); % 为新用户和上个用户生成间隔
        c(i) = c(i - 1) + x(i); % 迭代
        b(i) = max(c(i), e(i-1)); % 开始服务时间 = =max(i到达时间, 上个人服务结束时间)
    end
    n(k) = i - 1;
    t(k) = w / n(k);
end
disp([num2str(day),'个工作日中，银行每日平均服务的客户人数为: ',num2str(mean(n))])
disp([num2str(day),'个工作日中，银行每日客户的平均等待时间为: ',num2str(mean(t))])

toc







