%% 利用神经网络对棉花产量进行预测
clear; clc

%% 加载数据
% 记住是以行为样本还是以列为样本
% 我们这里一行是一个指标，列是属性
load seeddata.mat

%% 然后使用神经网络进行预测
predict_target = sim(net1, predict_sample');
predict_result = predict_target'