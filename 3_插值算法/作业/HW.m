clear; clc

%% ����
% load A1����2.mat % ����aA1��������2����
% x = 1:2:15
% y= OtherData(1,:)
% new_x = 1:1:15
% figure(1)
% plot(x,y,'o',new_x,pchip(x,y,new_x), 'r-', new_x,spline(x,y,new_x),'b-')
% legend("������", "���ΰ������ز�ֵ","����������ֵ","location","southEast")
% 
% 


%% ��ʼ��д
clear; clc
% load A1����2.mat % OtherData
load A2��������.mat % OtherData
[n, m] = size(OtherData) % ��������
ylab={'����','�ֳ�','����','COD','ˮ��','PHֵ','�ζ�','͸����','�ܼ��','������','͸����','������'};  % �Ȼ�Ҫ����ͼ�εı�ǩ

figure(1)

result=[];

for i = 1 : n % ��ÿһ�н��в���
    y = OtherData(i,:) % ÿһ�и���y
    p = pchip(1:2:15, y, 1:15) % ֱ�Ӱ�1:15Ԥ��ֵͬͳһ����p
     result(i, : ) = p; % ��Ԥ�����ֵ,���뵽��������� % ��䱨��˵ʲô��Ԥ�����ڴ�������ٶȣ�����Ҫ��ǰ����ͬ��zeros��
    
    subplot(4,3,i)
    plot(1:2:15,y,'o', 1:15,p,'r-')
  
    ylabel( ylab(i))
end

legend('ԭʼ����','���ΰ������ز�ֵԤ��','Location','southEast')





