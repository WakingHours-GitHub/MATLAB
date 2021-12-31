
clear; clc
load data.mat

%% ȷ�������ؼ������Ｏ��Ȩ��
% ���ؼ���������Ŀ(��һ��)
% ���Ｏ�����ַ���(��һ��)
% Ȩ��: ��"ר��"����(�Լ���,��),�����ݵ�����¿�������Ȩ�����,����Ҳ������AHP��ȷ��

A = [0.25 0.20 0.20 0.1 0.25];

%% ȷ����������

fa = @(x) x/8800;
fb = @(x) 1-x/8000;
a1 = 5.50000;a2 = 8.0;
fc = @(x) 1 .* (x>=0 & x<=a1) + ((a2-x)/(a2-a1)).*(x>a1 & x<=a2) + 0.*(x>a2);

fd = @(x) 1 - x/200;

b1 = 1500;b2 = 50;
fe = @(x) ((x - b2 ) / (b1 - b2));

%% �����ۺ����о���

judgmentMatirx = [fa(data(1,:)); fb(data(2,:)); fc(data(3,:)); fd(data(4,:)); fe(data(5,:)) ];

result = A*judgmentMatirx;
disp('���յ��ۺ����ۣ�')
disp(result);

[sorted, index] = sort(result,'descend')
disp(['��������ѡ�õ�' num2str(index(1)) '������'] )