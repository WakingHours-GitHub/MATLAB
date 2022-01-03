%% 利用神经网络进行训练
clear; clc

load Mydata % 加载数据
% sample: 样本，是原始的数据
% target： 目标值，是原始数据对应的目标值
% predict——sample： 需要进预测的样本

%% 然后使用神经网络进行训练
% 使用神经网络工具箱
% Neural Net Fitting
% 保存结果得到神经网络训练的模型: 一般是net
% 然后我们需要使用训练好的模型, 对需要predict的数据进行prediction
% 我们需要使用sim进行预测 doc sim
% sim(神经网络, 需要预测的数据(列向量))

% sim(net1, predict_sample) % 如果输入行向量会报错
predict_target = sim(net1, predict_sample'); % 得到预测的数据
predict_target'


