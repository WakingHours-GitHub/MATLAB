% MatLab�����ĸ�ʽ
% function [����] = ������(�����б�)

% �������򻯵ĺ���:��Ҫ��������:�ֱ��Ǿ���,����,ԭ������
function [posit_x] = Positivization(x , type, i)

        if type == 1 % ��С��
            disp(['��' num2str(i) '��, �Ǽ�С��, ����:max - a;' ])
            posit_x = Min2Max(x) % ����min2max�����Լ�С������
            disp(['��' num2str(i) '�м�С�����򻯴������'])
            disp('')
        elseif type == 2 % �м���
            disp(['��' num2str(i) '�����м���,����:M = max(xi - xbest), xi = 1- abs(xi - xbast)/M'])
            bast = input('�������м�ֵ:')
            posit_x = Mid2Max(x,bast)
            disp(['��' num2str(i) '���м������򻯴������'])
        elseif type == 3
            disp(['��' num2str(i) '��������'])
            a = input('�������������½�:[a,b]:')
            
            while size(a,1) > 2 || size(a ,2) > 2
                disp("ֻ���������Ͻ� �½硣����������")
                a = input('�������������½�:[a,b]:')
            end
            
            posit_x = Inter2Max(x, a(1), a(2))
            disp(['��' num2str(i) '���Ѿ��������'])
        else
            disp('�������,����Ƿ�ֻ����1,2,3�⼸�����͵�ָ��')
            
        end
        
end