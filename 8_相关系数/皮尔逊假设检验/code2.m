clear; clc
%% ��������
% ��.mat�ļ����ļ����пո�����Ҫ������
load 'women wear data.mat' % data 
% ����ָ��, ���Ǳ���(����) 

%% ����ͳ��������
% Ĭ�϶���dism = 1�����в���
MIN = min(data); % ����һ��������,��ÿһ�е���Сֵ
MAX = max(data);
MEAN = mean(data) ;
MEDIAN = median(data); % ����һ��������, ÿһ�е���λ��
SKEWNESS = skewness(data); % ÿһ�е�ƫ��
KURTOSIS = kurtosis(data); % ÿһ�еķ��
STD = std(data); % ÿһ�еı�׼��

RESULT = [MIN; MAX; MEAN; MEDIAN; SKEWNESS; KURTOSIS; STD] % ��ָ�����һ������
[n m] = size(RESULT)

% ��������ͳ�Ƶõ��ľ���,�������ۺ�,���뵽������ȥ
% ������ͳ�ƿ�����SPSS����

%% ����������ϵ��
% ����������ϵ��֮ǰ, ��Ҫ����������֮���ɢ��ͼ, ȷ���Ƿ��������

%% ����ɢ��ͼ
% ��matab����ͼ��
figure(1)
p = 1
for i = 1 : size(data, 2)
    for j = i+1 : size(data,2)
        subplot(4,4,p)
		plot(data(:,i) , data(:,j) ,'ro')
        p = p+1
    end
    
end

% ʵ��������ʹ��Spss�ȽϷ���: ͼ�� - �ɶԻ��� - ɢ��ͼ/��ͼ - ����ɢ��ͼ


%% �������ϵ����
R = corrcoef(data) % һ��������ʱ�򷵻�����ֵ��һ�������ϵ����һ����P

% Ȼ�����Excel�������ݻ�����


%% Ƥ��ѷ������鲿�֣�
% �������ã�
conint = 0.975; %  confidence interval ��������
n = 28 % ���ɶ�

x = -4:0.1:4; % �õ�һ��-4��4���Ϊ0.1�ĵȲ�����
y = tpdf(x, n); % ����t�ֲ��ĸ����ܶȺ�����xΪ�Ա�����28Ϊ���ɶ�
figure(2)
plot(x,y,'-') % ��������ͼ
grid on; % ��ʾ������
hold on; % ������figure2��ͼ
% ����a��λ�����ٽ�ֵ��tinvΪt�ֲ��ĸ����ܶȵķ�����
% tinv(conint, n)

% ����������;ܾ���ķָ���
% ǰ����x��������x��Ӧ��y����һ������(tinv,0) �ڶ������ǣ�tinv, tpdf(tinv)) ����������һ������
plot([tinv(conint, n), tinv(conint, n)], [ 0, tpdf(tinv(conint, n),n)],'r-') % �ұ�
plot([-tinv(conint, n), -tinv(conint, n)], [ 0, tpdf(-tinv(conint, n),n)],'r-') % ���

%% ����pֵ���ⲿ��û̫������


x = -4:0.1:4;
y = tpdf(x, n);
figure(3)
plot(x,y,'-');
% legend
grid on; 
hold on;
plot([-3.055,-3.055],[0,tpdf(-3.055,28)],'r-')
plot([3.055,3.055],[0,tpdf(3.055,28)],'r-')
disp('�ü���ֵ��Ӧ��pֵΪ��')
disp((1-tcdf(3.055,28))*2)  %˫������pֵҪ����2




[R, P] = corrcoef(data)







%% ����SPSS��
% [����] [���] [˫����]
% ����ѡ�����ϵ��:Ƥ��ѷ, ˹Ƥ����
% ˫β,��β ���Ӧ˫��͵���

























