function [posit_x] = Inter2Max(x, a ,b)
        row = size(x,1) % ����x����
        M =  max( [ a - min(x), max(x) - b] )
        % zeros(m,n) ����һ��m*n�ľ���Ԫ��ȫΪ0��ones() ͬ��
        posit_x = zeros(row, 1); % ����һ����xһ��ͬ�׵ľ���
        % �Ը��е�ÿһ�����ݽ��в�������ֵ��posit_x
        for i = 1 : row 
            if x(i) < a
                posit_x(i) = 1 - (a - x(i) ) / M;
            elseif x(i) > b
                posit_x(i) = 1 - ( x(i) - b) / M;
            else
                posit_x(i) = 1; % �������ڣ�Ϊ1
            end
            
end