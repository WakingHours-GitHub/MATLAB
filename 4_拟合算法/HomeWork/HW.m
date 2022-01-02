
clear; clc
load data2.mat % year��population

[n,m] = size(year)
figure(1)
plot(year, population, 'o') 



%% ѡ����Ϻ���
hold on;
grid on;

%% y = kx + b
k_hat =( n*sum(year.*population) - sum(year)*sum(population) ) / ( n * sum(year.*year) - sum(year)*sum(year))
b_hat=(sum(year.*year) *sum(population) - sum(year)*sum(year.*population) ) / (n * sum(year.*year) - sum(year) *sum(year))

f1 = @(x) k_hat * x+b_hat % ��������������xΪ������ʱ���õ���f1Ҳͬ��Ϊ������

fplot(f1,[2008, 2018])

% ��������Ŷ�
y1_hat = f1(year); % ʵ����

SST = sum ( (population - mean(population)) .^2 )
SSE = sum ( ( population - y1_hat) .^2 )
SSR = sum ( (y1_hat - mean( population)).^2)

if SST - SSE - SSR <= 1e-8 % �������������һ�������Բ�����==���ж�
    disp('����Ϊ����')
     R2 = SSR/SST % ��������Ŷ�
else
    disp('����δ����')
end


%% ָ��ģ��
figure(2)
plot(year, population, 'o') 
hold on;
grid on; % ������ͼ�����һ���������

% % ģ�����
% a = ?
% b = ?


f2 = @(x) a*exp(b*x)

plot(year, f2(year), '-')

















