function [posit_x] = Mid2Max(x ,bast) % 针对中间型指标
            posit_x = 1 - abs(x - bast) / (max(abs(x - bast)));
%         M = max(abs(x - bast));
%         posit_x = 1 - abs(x - bast) / M;
    
end