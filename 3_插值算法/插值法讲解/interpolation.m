clear; clc

%% һά������
x = -pi:pi
y =sin(x)
new_x = -pi : 0.01 : pi

p1 = pchip(x, y, new_x) % ���ΰ������ز�ֵ(һ�׵������)
p2 = spline(x, y, new_x) % ����������ֵ(���׵���Ҳ���)
% ��������ֺ������Ǹ�������x,y,Ȼ������µ�x�����µ�y
% New_Y = pchip(Old_X, Old_Y, New_X)
% New_Y = spline(Old_X, Old_Y, New_X)

figure(1)
subplot(2,2,1)
plot(x,y,"go",new_x, p1 ,"b-", new_x,p2,'r-')
legend("������",'���ΰ������ز�ֵ','����������ֵ', 'Location' ,'SouthEast') % ���ò���


clear; clc


%% nά����
x = -pi:pi
y = sin(x)
new_x = -pi:0.01:pi;
p = interpn(x,y,new_x,'spline') % ��ά��ֵ��Ӧ��spline�㷨
% figure(2) % ����subplot ֱ�ӰѶ���ͼ����һ������ȥ
subplot(2,2,2)
plot(x,y,"ro",new_x,p,'b-')
legend("������", "��ά����������ֵ")

clear; clc


%% Ԥ��
% population=[133126,133770,134413,135069,135738,136427,137122,137866,138639, 139538];
% year = 2009:2018;
load data.mat
new_x = 2019:2023;
p1 = pchip(year, population, new_x);
p2 = spline(year, population, new_x);

% figure(2)
subplot(2,2,[3,4])
plot(year, population, 'o',new_x, p1 ,'b+-', new_x,p2,'r*-')
legend("������","���ΰ������ز�ֵԤ��","����������ֵԤ��",'Location','southeast')











