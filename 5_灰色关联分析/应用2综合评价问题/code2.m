clear; clc
load data_water_quality.mat; % X ��ŵ����ĸ�ָ��
load X_name.mat; % X_name ��ŵ������е�����

% ��ָ��������򻯣�
[n, m] = size(X);
disp([ '����' num2str(n) '�����۶���, ' num2str(m) '������ָ��'])
Judge = input(['��' num2str(m) '������ָ���Ƿ���Ҫ����? (1��Ҫ��0����Ҫ��'])

if Judge == 1 % ��Ҫ���򻯵��б��
    disp(X_name(1,:)) % ��ӡ�⼸�е�����
    fprintf("��һ����Ҫ���򻯣�\n ")
    Position = input("���þ�����ʽ[ ]����:") % ��Ҫ���򻯵��б��
    
    fprintf("��ֱ������⼸��������ָ������\n (1Ϊ��С�ͣ�2Ϊ�м��ͣ�3Ϊ������)\n")
    
	for i = 1 : size(Position, 2)
		fprintf("��%d�� ",Position(i))
    end
    Type = input("�ֱ���ʲôָ������\n���þ���[]����"); % �����⼸�е�ָ������
    
    % ���ﻹ��Ҫ����һ��˵�������
    
    for i = 1 : size(Position, 2)  % �ԷǼ�����ָ�ָ꣬�����򻯣���ÿһ�н�������
        X(:, Position(i)) = Positivization(X(:,Position( i)), Type(i), Position(i)); 
    end
	
    disp('���򻯺�ľ���')
    disp(X)
	
else
    disp('����Ҫ���򻯣�������һ��')

end

%% �����򻭺�ľ������Ԥ����
Mean = mean(X, 1) %��ÿһ�е�ƽ��ֵ
Z = X ./ repmat(Mean, size(X,1), 1); % ���Ƴ�ͬ�ף�Ȼ���������׼��
disp('Ԥ�����ľ���Ϊ��');disp(Z)

%% ����ĸ���к�������
% ��Ӧ��1��ͬ������ĸ����Ϊ����ģ���ÿһ�е����ֵ���ɵ���������ʾĸ����
Y = max(Z,[],2); % һ�е����ֵΪ������
X = Z; % �����о���Ԥ���������ݾ���

%% ����÷�
absX0_X1 = abs(X - repmat(Y,1,size(X,2))) % ����|X0 - Xi|����
a = min(min(absX0_X1)); % ����������С��
b = max(max(absX0_X1)); % ������������
rho = 0.5; % �ֱ�ϵ��

gamma = (a + rho*b) ./ (absX0_X1 + rho*b) % �����������и���ָ����ĸ���еĹ���ϵ��
weight = mean(gamma) / sum(mean(gamma)); % �����������еĸ���ָ��Ļ�ɫ�����ȼ���Ȩ�أ���������

score = sum(X .* repmat(weight,size(X,1),1),2) % δ��һ���ĵ÷�(��������

Stand_socre = score ./ sum(score)
[sorted index] = sort(Stand_socre,'descend') % ��������















