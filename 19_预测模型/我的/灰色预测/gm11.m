% function [result, x0_hat, relative_residuals, eta] = gm11(x0, predict_num)
function [result] = gm11(x0, predict_num)
    % function: use traditional GM(1,1) model to predict
    % params:
    %   x0: source data
    %   predict_num: Predict periods
    % out put:
    %   result: predict result
    %   x0_hat: source data fitting values
    %   relative_residuals: ��Բв�
    %   eta: ��ģ�ͽ�������ʱ�õ��ļ���ƫ��
    n = length(x0); % ����ԭʼ���ݵĳ���
    x1 = cumsum(x0); % ����һ���ۼӺ�
    z1 = (x1(1:end-1) + x1(2:end)) / 2; % ������ھ�ֵ��������.-> ���ڵ�x1��ƽ��ֵ
    % �ӵڶ��ʼ��x0����y, z1����x, ������һ�λع� y = kx + b
    y = x0(2:end);
    x = z1;
    
    % ��������(��С���˷�:OSL��)
    k_hat = ((n-1) * sum(x.*y) - sum(x) * sum(y)) / ((n-1) * sum(x.*x) - sum(x) * sum(x));
    b_hat = (sum(x.*x) * sum(y) - sum(x) * sum(x.*y)) / ((n-1) * sum(x.*x) - sum(x)*sum(x));
    a = -k_hat; % a = -k, Ϊ��չϵ��
    
    disp('���ڽ���GM(1, 1)Ԥ�������: ');
    disp(mat2str(x0')); % mat2str����ת�����ػ����� ת����Ϊ�ַ���
    disp(['OSL���Ƶõ��ķ�չϵ��Ϊ-a: ', num2str(-a), '��������bΪ: ', num2str(b_hat)]);

    result = zeros(predict_num, 1); % ��ʼ��������, ���ں�������Ԥ�������
    for i = 1: predict_num
        result(i) = (1-exp(a))*(x0(1)-b_hat/a)*exp(-a*(n+i-1)); % ���빫ʽֱ�Ӽ���
    end
    
%     % ����������� compute output parms
%     x0_hat = zeros(n, 1); % x0_hat���������洢��x0���е����ֵ�������Ƚ��г�ʼ��
%     
%     x0_hat(1) = x0(1); % ��һ������
%     for m = 1: n-1
%        x0_hat(m+1) = (1-exp(a))*(x0(1)-b_hat/a)*exp(-a*m); % ����õ�
%     end
    

    
%     % ������Բв����Բв�
%     absolute_residuals = x0(2:end) - x0_hat(2:end);   % �ӵڶ��ʼ������Բв��Ϊ��һ������ͬ��
%     relative_residuals = abs(absolute_residuals) ./ x0(2:end);  % ������Բвע�����Ҫ�Ӿ���ֵ��
%     % ���㼶�� �� ����ƫ��
%     class_ratio = x0(2:end) ./ x0(1:end-1) ;  % ���㼶�� sigma(k) = x0(k)/x0(k-1)
%     eta = abs(1-(1-0.5*a)/(1+0.5*a)*(1./class_ratio));  % ���㼶��ƫ�� 1 - ... (һ�����ѧ��ʽ)
%     
%     % ������ô�����Ϊ�˷��ص�main������,���Խ���˵�������.
    
    
end