function [posit_x] = Mid2Max(x ,bast) % ����м���ָ��
            posit_x = 1 - abs(x - bast) / (max(abs(x - bast)));
%         M = max(abs(x - bast));
%         posit_x = 1 - abs(x - bast) / M;
    
end