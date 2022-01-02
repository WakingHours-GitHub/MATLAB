clear; clc

%% 测试
% load A1附件2.mat % 加载aA1池塘附件2数据
% x = 1:2:15
% y= OtherData(1,:)
% new_x = 1:1:15
% figure(1)
% plot(x,y,'o',new_x,pchip(x,y,new_x), 'r-', new_x,spline(x,y,new_x),'b-')
% legend("样本点", "三次埃尔米特插值","三次样条插值","location","southEast")
% 
% 


%% 开始编写
clear; clc
% load A1附件2.mat % OtherData
load A2完整数据.mat % OtherData
[n, m] = size(OtherData) % 返回数据
ylab={'周数','轮虫','溶氧','COD','水温','PH值','盐度','透明度','总碱度','氯离子','透明度','生物量'};  % 等会要画的图形的标签

figure(1)

result=[];

for i = 1 : n % 对每一列进行操作
    y = OtherData(i,:) % 每一行赋给y
    p = pchip(1:2:15, y, 1:15) % 直接把1:15预测值同统一赋给p
     result(i, : ) = p; % 将预测的数值,插入到结果矩阵里 % 这句报错，说什么请预分配内存以提高速度，我是要提前分配同阶zeros吗
    
    subplot(4,3,i)
    plot(1:2:15,y,'o', 1:15,p,'r-')
  
    ylabel( ylab(i))
end

legend('原始数据','三次埃尔米特插值预测','Location','southEast')





