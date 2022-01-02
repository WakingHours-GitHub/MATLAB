clear; clc
load data1.mat; % data

% %% һ��С����
% figure(1)
% plot(data(:,1), data(:,2),'o')
% xlabel("x��ֵ")
% ylabel('y��ֵ')

%% �����С���˷�
%% ��ʽ�Ǳʼ�
clear; clc
load data1.mat
x = data(:,1);
y = data(:,2);
figure(2)
plot(data(:,1),data(:,2),'o')
% ��ʾx,y���ǩ
xlabel('x��ֵ')
ylabel('y��ֵ')
n = size(data(:,1),1)

% ��ʽ�����������(����õ�������ͳ����������һ���Ի��߼�����Ȼ���Ƽ��������)
% n���������������������������������
k = (n*sum(x.*y) - sum(x)*sum(y) )/ ( n*sum(x.*x) - sum(x)*sum(x));
b = ( sum(x.*x)*sum(y) - sum(x)*sum(x.*y))  / (n * sum(x.*x) - sum(x)*sum(x))

hold on % ��������һ��ͼ��
grid on % ��ʾ�����

% ��������
% handle = @(argList)anonymous_function
% handle�����ٵ�����������ʱ������
f = @(x) k*x+b % ������궨��
% fplot���������ڻ�������1һԪ������ͼ��
% fplot(f, xinterval)����������f��ָ������xinterval��ͼ
% xinterval = [xmin, xmax]��ʾ������ķ�Χ, ���Դ���ʱ�������������������������Ǿ���
fplot(f,[2.5,7]) % ����е�����
legend('��������','��Ϻ���','location','southEast') % ��legend




%% ��������Ŷ�
y_hat = f(x) % ��Ϻ���
SST = sum((y - mean(y)).^2)
SSE = sum((y - y_hat).^2 )
SSR = sum((y_hat - mean(y)).^2)

if(SST - SSE - SSR <= 1e-8)
    disp('����Ϻ���Ϊ��������')
else
    disp('����Ϻ���Ϊ������')
end

R_2 = SSR / SST








