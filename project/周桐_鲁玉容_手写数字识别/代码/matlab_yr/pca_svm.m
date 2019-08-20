%次函数是训练函数，训练60000张图片
clear;clc;
%清屏

%导入训练集train.x & train.y
train_x=importdata('F:\大三\数字媒体技术导论\MATLAB\practice\尝试中\train_x.mat');
train_y=importdata('F:\大三\数字媒体技术导论\MATLAB\practice\尝试中\train_y.mat');
test_x=importdata('F:\大三\数字媒体技术导论\MATLAB\practice\尝试中\test_x.mat');

training_samples=[]; %训练矩阵
train_label=[]; %训练标签,自认为训练的标签指的就是对应的数字

%用matlab自带的pca函数进行训练，转而使用princomp
tic %计时开始
for i=1:60000 %先用100张进行训练
    train_img=train_x(:,:,i);
    train_img=im2bw(train_img);%二值化
    training_samples=[training_samples;train_img(:)'];%将数字集并入train_samples里,一行表示一个数的矩阵
    find_y=find(train_y(:,i,1));
    x=i
    if find_y==10
        find_y=0;
    end
    train_label=[train_label;find_y];%对数字集进行标记，以列向量的形式呈现
end
training_samples=double(training_samples); %一定要转成double类型
mu=mean(training_samples);
%%%此时training_samples里面的一行表示的是一个数字，对应的也是train_label里面的行
%%%以上即是从图片矩阵对应数字标签
%%%以上都是没有问题的

%测试程序，可删
% training_samples
% [sx,sy]=size(training_samples)
%可删

[train_coeff,train_scores,train_latent,train_tsquare]=princomp(training_samples,'econ');% pca
%可删
% train_coeff
% train_scores
% train_latent
% train_tsquare
% [x1,y1]=size(train_coeff)
% [x2,y2]=size(train_scores)
% [x3,y3]=size(train_latent)
% [x4,y4]=size(train_tsquare)
%可删
%%%princomp函数详解
%COEFF是X矩阵所对应的协方差阵V的所有特征向量组成的矩阵，即变换矩阵或称投影矩阵，COEFF每列对应一个特征值的特征向量，列的排列顺序是按特征值的大小递减排序
%返回的SCORE是对主分的打分，也就是说原X矩阵在主成分空间的表示。SCORE每行对应样本观测值，每列对应一个主成份(变量)，它的行和列的数目和X的行列数目相同。
%返回的latent是一个向量，它是X所对应的协方差矩阵的特征值向量。
%返回的tsquare，是表示对每个样本点Hotelling的T方统计量
%当维数p超过样本个数n的时候，用[...] = princomp(X,'econ')来计算，这样会显著提高计算速度
%要使得cumsum(latent)./sum(latent)能够大于98%,达到降维的效果

%由于某些原因，貌似是pca这个函数使用的并不频繁，先放弃直接使用这个函数，转而使用princomp这个函数进行pca算法的实现
% [train_coeff,train_scores,~,~,train_explained,mu]=pca(training_samples);% pca
%%%pca函数介绍
%[coeff,score,latent,tsquared,explained,mu]=pca(x)
%其中x是数据集，该矩阵表示的是一个样本，行数表示的是样本数
%coeff表示的是为X所对应的协方差矩阵的特征值向量
%返回的SCORE是对主分的打分，也就是说原X矩阵在主成分空间的表示。SCORE每行对应样本观测值，每列对应一个主成份(变量)，它的行和列的数目和X的行列数目相同。
%latent为特征值组成的向量
%tsquared表示霍特林T方统计值
%

train_idx=find(cumsum(train_latent)/sum(train_latent)>0.9,1)%idx为前k个特征向量，explained特征值
%cumsum默认对列求和，如果是向量，直接求和即可
%选出贡献值超过90%的前train_idx列
%进行降维

train_coeff=train_coeff(:,1:train_idx);%投影向量 %取出train_coffee第一列到第idx列的向量
train_img_arr=train_scores(:,1:train_idx);%特征向量，训练的样本集


% %SVM训练
model=svmtrain(train_label,train_img_arr,'-s 0 -s 1.5 -t 0 -g 3');
save('F:\大三\数字媒体技术导论\MATLAB\practice\handwrite_model_60000','model');%保存训练好的svm模型
xlswrite('F:\大三\数字媒体技术导论\MATLAB\practice\train_coeff_60000.xlsx',train_coeff); %保存特征向量
mu_1=mu';%不然写不进去,会报错
xlswrite('F:\大三\数字媒体技术导论\MATLAB\practice\mu_60000.xlsx',mu_1);%保存样本平均值，单样本进行测试的时候会用到


% %单个测试
% test_img1=test_x(:,:,199);
% imshow(test_img1);
% test_img1=double(test_img1);
% test_img1=im2bw(test_img1);

% %自己的手写数字
% test_img1=importdata('F:\大三\数字媒体技术导论\MATLAB\practice\store\用于识别的矩阵\number2_4')
% test_img1=imresize(test_img1,[28,28]);
% 
% %test_img1(:)' %表示一行
% test_img2=test_img1(:)'- mu %mu表示的是training_samples的平均值 %识别率更高
% test_img=test_img1(:)'
% test_img_arr=test_img2*train_coeff;
% [predict_label] =svmpredict(1,test_img_arr, model); 
% predict_label
toc
 
 
 
 

