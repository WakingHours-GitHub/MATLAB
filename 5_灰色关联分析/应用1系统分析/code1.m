
clear; clc
load data.mat % data

[n m] = size(data)

% Ԥ������׼��
stand_data = data./repmat(mean(data,1) ,n, 1);
disp('Ԥ�����ľ���')
stand_data

Y = stand_data(:, 1); % ĸ����
X = stand_data(:, 2 : end); % ������

absx0_x1 = abs(X - repmat(Y, 1 ,size(X,2))) % ����ز�ֵ�����ȸ�����Xͬ�׵�ĸ���У�Ȼ�������
a = min(min(absx0_x1)) % ����С
b = max(max(absx0_x1)) % �����

rho = 0.5 % �ֱ�ϵ��(ͨ��ȡ0.5)
gema = (a + rho * b) ./ (absx0_x1 + rho*b)
disp('�������и���ָ��Ļ�ɫ�����ȷ�����')
gema % ��ӡ

% �Ի�ɫ����������׼��
disp('�����л�ɫ�����ȷֱ�Ϊ��')
sum(gema,1)/n