%test_svm的结果
train_coeff=xlsread('F:\大三\数字媒体技术导论\MATLAB\practice\train_coeff_60000.xlsx');%读取对应存储的特征向量
mu=xlsread('F:\大三\数字媒体技术导论\MATLAB\practice\mu_60000.xlsx');%读取对应的平均training_samples，训练集的平均值,保存进来的其实已经转置了
model=importdata('F:\大三\数字媒体技术导论\MATLAB\practice\handwrite_model_60000.mat');%读取训练好的model

mu=mu';
%次函数是训练函数，训练60000张图片

%导入测试集test.x & test.y
test_x=importdata('F:\大三\数字媒体技术导论\MATLAB\practice\test_x.mat');
test_y=importdata('F:\大三\数字媒体技术导论\MATLAB\practice\test_y.mat');

test_samples=[]; %测试矩阵
test_label=[]; %测试标签,自认为训练的标签指的就是对应的数字

%用matlab自带的pca函数进行测试，转而使用princomp
tic %计时开始
for i=1:10000 
    find_y=find(test_y(:,i,1));
    x=i
    if find_y==10
        find_y=0;
    end
    test_label=[test_label;find_y];%对数字集进行标记，以列向量的形式呈现
end

imgs=test_x;
num_new=1000
nums=[];%存储得到的数字数组
num_true=0;
for i=1:num_new
    img=imgs(:,:,i);
    img=im2bw(img);%二值化处理
    test_img2=img(:)'- mu; %mu表示的是training_samples的平均值 %识别率更高
    test_img_arr=test_img2*train_coeff;
    [predict_label] =svmpredict(1,test_img_arr, model); 
    nums(i)=predict_label
    if predict_label==test_label(i)
        num_true=num_true+1;
    end
end
num_true
accuracy=num_true/num_new
toc
 
 
 
 

