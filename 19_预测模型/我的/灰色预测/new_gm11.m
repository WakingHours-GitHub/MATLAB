function [result] = new_gm11(x0, predict_num)
% �������ã�ʹ������Ϣ��GM(1,1)ģ�Ͷ����ݽ���Ԥ��
% �������
%     x0��ҪԤ���ԭʼ����
%     predict_num�� ���Ԥ�������
% �������
%     result��Ԥ��ֵ
    result = zeros(predict_num,1);  % ��ʼ����������Ԥ��ֵ������, Ԥ�����ڴ�
    for i = 1 : predict_num  
        result(i) = gm11(x0, 1);  % ��Ԥ��һ�ڵĽ�����浽result��
        x0 = [x0; result(i)];  % ����x0��������ʱx0�����µ�Ԥ����Ϣ
        % ��������Ӷ��һ��
    end
end