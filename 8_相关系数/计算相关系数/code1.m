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
% STD = std(data); % ÿһ�еı�׼��

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
R = corrcoef(data)

% Ȼ�����Excel�������ݻ�����








