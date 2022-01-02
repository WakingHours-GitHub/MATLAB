function [posit_x] = Min2Max(x)
        posit_x = max(x) - x;
%         posit_x = 1./x; % 在x矩阵所有都大于0的时可以使用(局限)

end