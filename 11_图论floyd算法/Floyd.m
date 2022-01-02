% �ú�����ʹ��Floyed�㷨, ������������ڵ�֮��ľ�����·��
% Floyd�㷨����һ�Σ��������нڵ�֮��ľ����·��

% �����б�: D: adjacent matrix �ڽӾ���
% ���:
% 		dist: ��̾������, dij��ʾi��j����̾���
%		path: ·������, pij��ʾi��j֮��ľ����ڵ�����
% adjacent matrix

function [dist, path] = Floyd(D)
    n = size(D, 1) % �����ж�����
    dist = D; % ��ʼ��

    path = zeros(n); % ��ʼ��n��0����
    for j = 1:n
        path(:, j) = j;
    end
    for i = 1:n
        path(i, i) = -1;
    end

    % Folyd�㷨����: ����ѭ��
    for k = 1 : n % �м�ڵ�k��1-nѭ��
        for i = 1 : n % ��ʼ�ڵ�i��1��1-nѭ��
            for j = 1 : n % ĩβ�ڵ�j��1-nѭ��
                % ��i,j���ڵ����̾������i��k����̾��� + k��j����̾���
                if dist(i,j) > dist(i,k) + dist(k,j)
                    % ����dist��path����
                    dist(i,j) = dist(i,k) + dist(k,j)
                    path(i,j) = path(i,k);
                end
            end
        end
    end
    
end