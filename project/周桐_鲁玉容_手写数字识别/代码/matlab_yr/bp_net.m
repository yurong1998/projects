clear;clc;
%清屏

%导入训练集train.x & train.y
train_x=importdata('F:\大三\数字媒体技术导论\MATLAB\practice\尝试中\train_x.mat');
train_y=importdata('F:\大三\数字媒体技术导论\MATLAB\practice\尝试中\train_y.mat');
test_x=importdata('F:\大三\数字媒体技术导论\MATLAB\practice\尝试中\test_x.mat');

training_samples=[]; %训练矩阵
train_label=[]; %训练标签,自认为训练的标签指的就是对应的数字
test_samples=[];

num=10000;
train_label=train_y(:,1:num,1);%按照原始数据读入，一列10行表示一个数，第i个为1，则这个数为i,10对应0
train_label=double(train_label);


tic %计时开始
for i=1:num %确定输入
    train_img=train_x(:,:,i);
    train_img=im2bw(train_img);%二值化
    training_samples=[training_samples,train_img(:)];%将数字集并入train_samples里,一行表示一个数的矩阵 ,先按列读取每一张图，把每张图的像素按列排
end
training_samples=double(training_samples); %一定要转成double类型
%个人认为这里不需要归一化，因为本身就是处于0,1两个数的
%隐含神经元取70个（最佳的）

%建立前向bp神经网络函数
net=newff(minmax(training_samples),[784 70 10],{'logsig','logsig','logsig'},'traincgb');
%training_samples为训练样本集合
%[784 70 10]为神经网络的层结构
%{'logsig','logsig','logsig'}为神经网络的各层的转移函数，均设置为对数S型激活函数
%训练函数采用'traincgb'，即采用共轭梯度法训练

net.trainParam.epichs=1000;%最大训练次数
net.trainParam.show=20; %显示的间隔次数
net.trainParam.min_grad=1e-10; %最小执行梯度
net.performFcn='sse'; %设置目标性能函数
net.trainParam.goal=0.01; %设置性能目标值
net.layers{1}.initFcn='initwb';%网络层的初始化函数为'initwb'
net.inputWeights{1,1}.initFcn='randnr'; %输入层权值向量初始化
net.inputWeights{2,1}.initFcn='randnr'; %第1网络层到第2网络层的权值向量初始化
net=init(net); %初始化网络
[net,tr]=train(net,training_samples,train_label);

save bp_10000 net 
% num_test=5;
% for i=1:num_test %确定输入
%     test_img=test_x(:,:,i);
%     test_img=im2bw(test_img);%二值化
%     test_samples=[test_samples,test_img(:)];%将数字集并入test_samples里,一行表示一个数的矩阵 ,先按列读取每一张图，把每张图的像素按列排
% end
% test_samples=double(test_samples); %一定要转成double类型
% test_out=sim(net,test_samples);%神经网络的仿真
% max_value=max(testout);%输出神经元的最大值
% if(max_value>0.7) %输出神经元的最大值大于0.7才进行数字识别，小于0.7时拒绝识别
%     testout=compet(testout);
%     number=find(testout==1)-1 %数字识别结果
% end

toc
 
 
 
 

