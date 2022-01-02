clear; clc

%% ͼ�ۻ���֪ʶ
% ����MatLab��ͼ

%% MatLab������ͼ:graph()����

% (1) ��Ȩ��(����ÿ���ߵ�Ȩ��Ĭ��Ϊ1)
% graph(s, t, [w]): ����s,��t��Ӧ�Ľڵ�֮�䴴��һ����(һһ��Ӧ), ����һ��graph����(ͼ)
% Ȼ�����plot(G)��������, s��t��ͬά
% ����Ҫ����Ȩ��, ������ڼ���Ȩ��

s1 = [1 2 3 4];
t1 = [2 3 1 1];

figure(1)
G1 = graph(s1,t1)
plot(G1)

% ע��: ��Ŵ�1��ʼ,�������,��Ҫ��Խ,�����Լ�������
% ����Խ�м����ֵ, matlab��ͼ��ʱ��ͻᱻ����, ��matlab��ͼ������, ������վ�л�ͼ
% ����:
s1 = [ 1 2 3 5];
t1 = [ 2 3 5 1];
figure(2)
G1 = graph(s1, t1) % ��ʱ
plot(G1)

% �ַ���Ҳ�ǿ�����matlab��������,��Ҫ�õ�Ԫ������
s2 = {'ѧУ','��ӰԺ','����','�Ƶ�'};
t2 = {'��ӰԺ','�Ƶ�','�Ƶ�','KTV'};
figure(3)
G2 = graph(s2, t2)
plot(G2, 'linewidth', 2) % ���ò���linewidth�߿�,Ϊ2
set(gca, 'XTick', [], 'YTick', []); % set����, gca������������,Ȼ���������Ϊ��
% ��������2019a��Graph�����Զ��Ͱ�������ɾ����

% (2)��Ȩ��:��Ҫ����Ȩ��, ������ڼ���Ȩ��w����
s3 = [1,2,3,4];
t3 = [2,3,1,1];
w3 = [3,8,9,2];
figure(4)
G3 = graph(s3, t3, w3);
plot(G3, 'EdgeLabel', G3.Edges.Weight, 'linewidth', 2) % EdgeLabel�ߵı�ǩ, G3.Edges.Weight
set(gca, 'XTick', [], 'YTick', []);



%% ����MatLab������ͼ��digraph()
s4 = [1 2 3 4 1];
t4 = [2 3 1 1 4];
G4 = digraph(s4, t4);
figure(5)
plot(G4)

% ��Ȩͼ
s5 = [1 2 3 4 1];
t5 = [2 3 1 1 4];
w5 = [3 8 1 2 3];
G5 = digraph(s5, t5, w5);
figure(6)
plot(G5, 'EdgeLabel', G5.Edges.Weight, 'linewidth', 2)
set(gca, 'XTick', [], 'YTick', []);







