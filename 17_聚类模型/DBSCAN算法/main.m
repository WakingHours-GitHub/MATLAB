%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPML110
% Project Title: Implementation of DBSCAN Clustering in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

clc;
clear;
close all; % ��������ռ�����б�������������MEX�ļ�

%% Load Data
% ��������

load mydata; % X

%% Run DBSCAN Clustering Algorithm
% ���ò���
epsilon=0.5;
MinPts=10;
IDX=DBSCAN(X,epsilon,MinPts);


%% Plot Results
% ��ͼ
% ���ֻҪ����ָ��Ļ��Ϳ��Ի�ͼ��
PlotClusterinResult(X, IDX);
title(['DBSCAN Clustering (\epsilon = ' num2str(epsilon) ', MinPts = ' num2str(MinPts) ')']);
