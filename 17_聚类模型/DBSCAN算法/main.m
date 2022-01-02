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
close all; % 清除工作空间的所有变量，函数，和MEX文件

%% Load Data
% 加载数据

load mydata; % X

%% Run DBSCAN Clustering Algorithm
% 设置参数
epsilon=0.5;
MinPts=10;
IDX=DBSCAN(X,epsilon,MinPts);


%% Plot Results
% 画图
% 如果只要两个指标的话就可以画图啦
PlotClusterinResult(X, IDX);
title(['DBSCAN Clustering (\epsilon = ' num2str(epsilon) ', MinPts = ' num2str(MinPts) ')']);
