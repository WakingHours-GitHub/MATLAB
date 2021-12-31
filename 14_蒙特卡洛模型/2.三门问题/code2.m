%% 蒙特卡洛模拟三门问题

%%三门问题描述:
% 三门问题（Monty Hall problem）亦称为蒙提霍尔问题、蒙特霍问题或蒙提霍尔悖论，
% 参赛者会看见三扇关闭了的门，其中一扇的后面有一辆汽车，选中后面有车的那扇门可赢得该汽车，另外两扇门后面则各藏有一只山羊。
% 当参赛者选定了一扇门，但未去开启它的时候，节目主持人开启剩下两扇门的其中一扇，露出其中一只山羊。
% 主持人其后会问参赛者要不要换另一扇仍然关上的门。问题是：换另一扇门会否增加参赛者赢得汽车的机率。如果严格按照上述的条件，那么答案是会。
% 不换门的话，赢得汽车的几率是1/3。换门的话，赢得汽车的几率是2/3。虽然该问题的答案在逻辑上并不自相矛盾，但十分违反直觉。

clear;clc


%% 预备知识
% randi([a,b],m,n):函数在指定区间内随机去除大小为m * n的矩阵
randi([1,5],3,4) % 在区间[1,5]中取出大小为3*4的随机数矩阵
randi([1,3]) % 在[1,3]中取出一个整数
% 复习一下字符串连接方式:
% (1)['字符串1', '字符串2', ...] % 拼接成一个矩阵
% (2)strcat('字符串1','字符串2', ...) % 用字符串连接函数

% num2str(): 将数值类型转换为字符串类型
% 因为在disp打印中,我们可以使用num2str()将数值转换为字符串,从而拼接成矩阵,从而打印
disp(['这是',num2str(1234),'数字'])
%% 代码部分:
% 在最后的条件下的概率(已知






