%% ���·���㷨

% ע��Ŷ��Matlab�е�ͼ�ڵ�Ҫ��1��ʼ��ţ����������0ȫ����Ϊ��9
% �������Ǵ�1��ʼ������ţ���Ҫ�Լ���㶨����
s = [9 9 1 1 2 2 2 7 7 6 6  5  5 4];
t = [1 7 7 2 8 3 5 8 6 8 5  3  4 3];
w= [4 8 3 8 2 7 4 1 6 6 2 14 10 9];

G = graph(s, t, w);
figure(1)
plot(G,'EdgeLabel',G.Edges.Weight, 'linewidth',2,)
set(gca,'XTick',[], 'YTick',[]);

% [P,d] = shortestpath(G,start,end [,'Method',algorithm] ) % Matlab��2015�汾��ų���
% G��graph����, start�ǿ�ʼ�ڵ�ı��, end��Ŀ��ڵ�ı��, �����ǿ�ѡ�Ĳ���,��ʾ���·�����㷨.
% p�����·�������Ľڵ�������, d�Ǿ���
[p d] = shortestpath(G, 9 ,4) % Ĭ��method Ϊ auto

% �������ǵ����·��
myplot = plot(G,'EdgeLabel', G.Edges.Weight, 'linewidth', 2)
highlight(myplot, p, 'EdgeColor', 'r') % highlight��ǽڵ㣬 Ȼ��ѡ�����Ӳ���EdgeColor����ɫ��Ϊr��red��


% �����������֮��ľ��룬����һ���������
% help distances: �� MATLAB ���� ���ؾ��� d������ d(i,j) �ǽڵ� i �ͽڵ� j ֮������·���ĳ��ȡ�
% ���ͼ�����˼�Ȩ���� G.Edges ��������Weight��������ЩȨ��������ͼ�и��ߵľ��롣�������б߾��붼��Ϊ 1��
% distances(graph)������ ����Ϊͼ����
% ����dij �ͱ�ʾi��j�ľ���
D = distances(G) 
D(1, 2) % ��ʾ��1��2��̵ľ���Ϊ6

% �ҳ�������Χ�����еĵ�: nearest(G, s, d)
% ����ͼG��, ��ڵ�s�ľ�����d�ڵ����нڵ�, �൱����s�ڵ�Ϊ����
% ���صĵ�һ������Ϊ�ڵ��ţ� �ڶ����������ڵ�ľ���
[nodeIDs, dist] = nearest(G, 2, 10)


