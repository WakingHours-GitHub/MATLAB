clear; clc
%% MATLAB求解解析解
%% 使用函数: dsolve('函数表达式', '指定的微分变量');
% 函数表达式我们用字符串包含, 几阶导数就用D几x, 例如y'就用Dy, y''就用D2y
% 对于新版本eqn, 几阶导数就用diff(y, 几阶)来求得

%% 例1: 求解y-dy=2x的数值解,
dsolve('y-Dy=2*x', 'x') % 需要注意的是, 我们要指定微分变量为x
% 得到的结果: 2*x + C1*exp(x) + 2 可以再实时脚本中打开, 使得输出结果更加准确
% (这里的C1表示任意常数，有时候也会出现C2 C3等)
dsolve('y-Dy=2*x')  % 如果不指定微分变量的话, 会默认微分变量为t, 那么x将会被看成一个常熟
% 2*x + C1*exp(t)

%% 不过最新版本的matlab使用dsolve()函数, 会发出警告
% 新版本的MATLAB推荐使用下面这种方式:
syms y(x) % 声明符号函数, 和符号变量
eqn = (y - diff(y, x) == 2*x) % 保存方程式 % 注意原来方程中的“=”一定要改成“==” (列出微分方程表达式)
dsolve(eqn) % 2*x + C1*exp(x) + 2


%% 若微分方程中还存在有其他的未知参数怎么办?
% 方法1:
dsolve('y-Dy=a*x', 'x')
% a + a*x - C1*exp(x)
% 方法2:
syms y(x) a; % 未知参数也需要定义
eqn = (y - diff(y)==a*x);
dsolve(eqn)
% a + a*x - C1*exp(x)

%% 例子2: 带有初始值的微分方程
% 求解y-dy=2x的数值解, 初始值y(0)=3, x范围[0, 2]
% 方法1: 直接使用dsolve方法
dsolve("y-Dy=2*x", "y(0)=3",  "x")
% 2*x + exp(x) + 2
% 方法2: 有初始条件的, 我们需要分别单独列写方程和条件
syms y(x)
eqn = (y - diff(y) == 2*x);
cond = (y(0) == 3); % 条件
dsolve(eqn, cond) % 2*x + exp(x) + 2

%% 例3:
% 求解: d2y+4dy+29y=0, 且y(0)=0, y'(0)=15
% 方法1:
dsolve("D2y+4*Dy+29*y=0", "y(0)=0", "Dy(0)=15", "x")
% 3*sin(5*x)*exp(-2*x)
% 方法2:
eqn = (diff(y, 2) + 4*diff(y)+29*y == 0);
Dy = diff(y, x); % 必须定义一下Dy为y的一阶导数, 
cond = [(y(0)==0), (Dy(0)==15)];
dsolve(eqn, cond) % 直接调用dsolve函数进行求解
% 3*sin(5*x)*exp(-2*x)

%% 例4: 多项式微分方程
% 方法1 -> 一行代码就可以搞定
A = dsolve("Dx=2*x-3*y+3*z+t", "Dy=4*x-5*y+3*z+t", "Dz=4*x-4*y+2*z+t", "t")
% 多行多列的情况下, 返回一个符号变量的结构体数组
A.x % exp(2*t)*(C3 - (exp(-2*t)*(2*t + 1))/4) + C1*exp(-t)
A.y % exp(2*t)*(C3 - (exp(-2*t)*(2*t + 1))/4) + C1*exp(-t) + C2*exp(-2*t)
A.z % exp(2*t)*(C3 - (exp(-2*t)*(2*t + 1))/4) + C2*exp(-2*t)
% 简化一下看看
x = simplify(A.x) % C1*exp(-t) - t/2 + C3*exp(2*t) - 1/4
y = simplify(A.y) % C1*exp(-t) - t/2 + C2*exp(-2*t) + C3*exp(2*t) - 1/4
z = simplify(A.z) % C2*exp(-2*t) - t/2 + C3*exp(2*t) - 1/4

% 我们也可以直接使用三个变量进行接收:
[x, y, z] = dsolve("Dx=2*x-3*y+3*z+t", "Dy=4*x-5*y+3*z+t", "Dz=4*x-4*y+2*z+t", "t")

% 方法2:
syms x(t) y(t) z(t)
eqn1 = (diff(x,t)==2*x-3*y+3*z+t);
eqn2 = (diff(y,t)==4*x-5*y+3*z+t);
eqn3 = (diff(z,t)==4*x-4*y+2*z+t);

result = dsolve(eqn1, eqn2, eqn3);
result.x  % exp(2*t)*(C3 - (exp(-2*t)*(2*t + 1))/4) + C1*exp(-t)
result.y % exp(2*t)*(C3 - (exp(-2*t)*(2*t + 1))/4) + C1*exp(-t) + C2*exp(-2*t)
result.z  % exp(2*t)*(C3 - (exp(-2*t)*(2*t + 1))/4) + C2*exp(-2*t)

simplify(y)  % simplify函数可以简化表达式
latex(y) % 转换成latex代码，复制到Axmath或者word自带的公式编辑器（低版本不知道支不支持）


% 老师给的代码: 
% 方法2 -> 就需要多行代码
syms x(t) y(t) z(t)
eqn1 = (diff(x,t)  == 2*x-3*y+3*z+t); 
eqn2 = (diff(y,t)  == 4*x-5*y+3*z+t); 
eqn3 = (diff(z,t)  == 4*x-4*y+2*z+t); 
eqns = [eqn1 eqn2 eqn3];
[x,y,z] = dsolve(eqns)
% x = exp(2*t)*(C2- (exp(-2*t)*(2*t + 1))/4) + C3*exp(-t)
% y = exp(2*t)*(C2 - (exp(-2*t)*(2*t + 1))/4) + C3*exp(-t) + C4*exp(-2*t)
% z = exp(2*t)*(C2 - (exp(-2*t)*(2*t + 1))/4) + C4*exp(-2*t)
% mupad  % 最新版本matlab可能会报错，将计算结果复制到里面，使结果可读。
% 如果新版matlab用不了mupad的话，可以使用更新13中介绍到的实时脚本
simplify(y)  % simplify函数可以简化表达式
latex(y) % 转换成latex代码，复制到Axmath或者word自带的公式编辑器（低版本不知道支不支持）
% 如果太过于复杂的话可能会报错，大家可以自己测试


%% 但是, 并不是所有的微分方程都可以求解得到解析解, 例如导弹追击哪一题就没有解析解
% 于是我们只能求解数值解
% 我们直接假设v=100
[x,y] = dsolve('Dx = 3*100*(20+sqrt(2)/2*100*t-x)/sqrt((20+sqrt(2)/2*100*t-x)^2+(sqrt(2)/2*100*t-y)^2)',...
                'Dy = 3*100*(sqrt(2)/2*100*t-y)/sqrt((20+sqrt(2)/2*100*t-x)^2+(sqrt(2)/2*100*t-y)^2)','x(0)=0,y(0)=0','t')  

% 求解不出来, 我们等后面有如何求解数值解的时候再来看这道题

















