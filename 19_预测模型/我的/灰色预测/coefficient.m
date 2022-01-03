function [x0_hat, relative_residuals, eta] = coefficient(x0)
    % ����ϵ��
    
    n = length(x0); % 
    x1=cumsum(x0); % ����һ���ۼ�ֵ
    z1 = (x1(1:end-1) + x1(2:end)) / 2;  % ������ھ�ֵ�������У�����Ϊn-1�� -> ���ڵ�x1��ƽ��ֵ
    % ���ӵڶ��ʼ��x0����y��z1����x��������һԪ�ع�  y = kx +b
    y = x0(2:end); % -> Ҫ��2�ʼȡ
    x = z1; 
    
    k = ((n-1)*sum(x.*y)-sum(x)*sum(y))/((n-1)*sum(x.*x)-sum(x)*sum(x));
    b = (sum(x.*x)*sum(y)-sum(x)*sum(x.*y))/((n-1)*sum(x.*x)-sum(x)*sum(x));
    a = -k;  %ע�⣺k = -aŶ -> ��չϵ��
    % �������ֵ
    x0_hat=zeros(n,1);  x0_hat(1)=x0(1);   % x0_hat���������洢��x0���е����ֵ�������Ƚ��г�ʼ��
    for m = 1: n-1
        x0_hat(m+1) = (1-exp(a))*(x0(1)-b/a)*exp(-a*m);
    end
    % ������Բв����Բв�
    absolute_residuals = x0(2:end) - x0_hat(2:end);   % �ӵڶ��ʼ������Բв��Ϊ��һ������ͬ��
    relative_residuals = abs(absolute_residuals) ./ x0(2:end);  % ������Բвע�����Ҫ�Ӿ���ֵ������Ҫʹ�õ��
    % ���㼶�� �� ����ƫ��
    class_ratio = x0(2:end) ./ x0(1:end-1) ;  % ���㼶�� sigma(k) = x0(k)/x0(k-1)
    eta = abs(1-(1-0.5*a)/(1+0.5*a)*(1./class_ratio));  % ���㼶��ƫ�� 1 - ... (һ�����ѧ��ʽ)


end
