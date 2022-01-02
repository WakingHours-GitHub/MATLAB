%% topsis���ӽ���뷨

clear;clc
load data_water_quality.mat % X
load X_name % X_name

[n, m] = size(X)
disp([ '����' num2str(n) '�����۶���, ' num2str(m) '������ָ��'])

%% �ж��Ƿ���Ҫָ������
Judge = input(['��' num2str(m) '������ָ���Ƿ���Ҫ����? (1��Ҫ��0����Ҫ��'])

if Judge == 1 % ��Ҫ���򻯵��б��
    
    disp(X_name(1,:)) 
    fprintf("��һ����Ҫ���򻯣�\n ")
    Position = input("���þ�����ʽ[ ]����:") % ��Ҫ���򻯵��б��
    fprintf("��ֱ������⼸��������ָ������\n 1Ϊ��С�ͣ�2Ϊ�м��ͣ�3Ϊ������\n")
    
    Type = input("�þ���[]����"); % �����⼸�е�ָ������
    
    % ���ﻹ��Ҫ����һ��˵�������
    
    for i = 1 : size(Position, 2)  % �ԷǼ�����ָ�ָ꣬������
        X(:, Position(i)) = Positivization(X(:,Position( i)), Type(i), Position(i)); 
         
    end
    disp('���򻯺�ľ���')
    disp(X)
    
else
    disp('����Ҫ����')

end

%% �ж��Ƿ���Ҫ����Ȩ��
disp('�Ƿ���Ҫ����Ȩ��(1: ��Ҫ, 0: ����Ҫ):')
judge = input('');
if judge == 1
	isOk = 0 % �ж�weighȨ�������Ƿ���ȷ
	while isOk == 0
		disp('�����������ָ��ͬ�׵�Ȩ�ؾ���, ������ӱ���Ϊ1')
		weigh = input(['����' num2str(m) '����ָ��, ������Ҫ1*' num2str(m) '��Ȩ�ؾ���'])
		
		if (abs(sum(weigh)-1 <= 1e-8)) && (size(weigh, 2) == m && size(weigh,1) == 1) % ����weigh�ӳ����õ�һ�������������Բ��������αȽϷ�ʽ
			isOk = 1;	
			disp('������ȷ')
		else
			disp('���벻��ȷ����������')
	
		end 
	
	end

else % ����ҪȨ�ص����
	% ��ʱweigh��һ�����������������������ַ�ʽ[ʵ����]

	weigh = ones(1, m) ./ m; % ������ҪȨ�أ���Ĭ��ȡ��ֵ
    
end

%% �����򻯺�ľ�����б�׼��(��׼����ʽ��pdf��)
Z = X ./ repmat(sum(X.*X) .^ 0.5, n, 1); 
disp('��׼���ľ��� Z = ')
disp(Z)

%% ���Ĳ����������ֵ����Сֵ֮��ľ��룬��������÷�

%% ���Ĳ������������ֵ�ľ������Сֵ�ľ��룬������÷�


D_P = sum([(Z - repmat(max(Z),n,1)) .^ 2 ] .* repmat(weigh,n,1) ,2) .^ 0.5;   % D+ �����ֵ�ľ�������
D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ] .* repmat(weigh,n,1) ,2) .^ 0.5;   % D- ����Сֵ�ľ�������
S = D_N ./ (D_P+D_N);    % δ��һ���ĵ÷�
% ��׼����
stand_s = S / sum(S)
[sorted_S, index] = sort(stand_s,'descend')