function [posit_x] = Inter2Max(x, a ,b)
        row = size(x,1) % 计算x行数
        M =  max( [ a - min(x), max(x) - b] )
        % zeros(m,n) 返回一个m*n的矩阵，元素全为0，ones() 同理
        posit_x = zeros(row, 1); % 返回一个跟x一列同阶的矩阵
        % 对该列的每一行数据进行操作，赋值给posit_x
        for i = 1 : row 
            if x(i) < a
                posit_x(i) = 1 - (a - x(i) ) / M;
            elseif x(i) > b
                posit_x(i) = 1 - ( x(i) - b) / M;
            else
                posit_x(i) = 1; % 在区间内，为1
            end
            
end