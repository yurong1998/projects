% function predict_num=predict_svm(img)
% %识别函数
% 
% train_coeff=xlsread('F:\大三\数字媒体技术导论\MATLAB\practice\train_coeff_60000.xlsx');%读取对应存储的特征向量
% mu=xlsread('F:\大三\数字媒体技术导论\MATLAB\practice\mu_60000.xlsx');%读取对应的平均training_samples，训练集的平均值,保存进来的其实已经转置了
% model=importdata('F:\大三\数字媒体技术导论\MATLAB\practice\handwrite_model_60000.mat');%读取训练好的model
% 
% %自己的手写数字
% %img
% mu=mu';
% %test_img1(:)' %表示一行
% test_img2=img(:)'- mu %mu表示的是training_samples的平均值 %识别率更高
% test_img_arr=test_img2*train_coeff;
% [predict_label] =svmpredict(1,test_img_arr, model); 
% predict_num=predict_label;
% end
%以上是一个数字一个数字识别
function predict_num=predict_svm(imgs,num_new)
%识别函数

train_coeff=xlsread('F:\大三\数字媒体技术导论\MATLAB\practice\train_coeff_60000.xlsx');%读取对应存储的特征向量
mu=xlsread('F:\大三\数字媒体技术导论\MATLAB\practice\mu_60000.xlsx');%读取对应的平均training_samples，训练集的平均值,保存进来的其实已经转置了
model=importdata('F:\大三\数字媒体技术导论\MATLAB\practice\handwrite_model_60000.mat');%读取训练好的model

%自己的手写数字
%img
mu=mu';
%test_img1(:)' %表示一行

nums=[];%存储得到的数字数组
for i=1:num_new
    img=imgs(:,:,i);
    imshow(img)
    test_img2=img(:)'- mu; %mu表示的是training_samples的平均值 %识别率更高
    test_img_arr=test_img2*train_coeff;
    [predict_label] =svmpredict(1,test_img_arr, model); 
    nums(i)=predict_label
end
predict_num=num2str(nums)
end
 
 
 
 


