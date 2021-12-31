% MatLab函数的格式
% function [返回] = 函数名(参数列表)

% 本次正向化的函数:需要三个参数:分别是矩阵,类型,原本的行
function [posit_x] = Positivization(x , type, i)

        if type == 1 % 极小型
            disp(['第' num2str(i) '列, 是极小型, 正向化:max - a;' ])
            posit_x = Min2Max(x) % 调用min2max函数对极小型正向化
            disp(['第' num2str(i) '列极小型正向化处理完成'])
            disp('')
        elseif type == 2 % 中间型
            disp(['第' num2str(i) '列是中间型,正向化:M = max(xi - xbest), xi = 1- abs(xi - xbast)/M'])
            bast = input('请输入中间值:')
            posit_x = Mid2Max(x,bast)
            disp(['第' num2str(i) '列中间型正向化处理完成'])
        elseif type == 3
            disp(['第' num2str(i) '是区间型'])
            a = input('请输入区间上下界:[a,b]:')
            
            while size(a,1) > 2 || size(a ,2) > 2
                disp("只允许输入上界 下界。请重新输入")
                a = input('请输入区间上下界:[a,b]:')
            end
            
            posit_x = Inter2Max(x, a(1), a(2))
            disp(['第' num2str(i) '列已经处理完毕'])
        else
            disp('输入错误,检查是否只输入1,2,3这几种类型的指标')
            
        end
        
end