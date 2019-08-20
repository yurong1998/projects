%�κ�����ѵ��������ѵ��60000��ͼƬ
clear;clc;
%����

%����ѵ����train.x & train.y
train_x=importdata('F:\����\����ý�弼������\MATLAB\practice\������\train_x.mat');
train_y=importdata('F:\����\����ý�弼������\MATLAB\practice\������\train_y.mat');
test_x=importdata('F:\����\����ý�弼������\MATLAB\practice\������\test_x.mat');

training_samples=[]; %ѵ������
train_label=[]; %ѵ����ǩ,����Ϊѵ���ı�ǩָ�ľ��Ƕ�Ӧ������

%��matlab�Դ���pca��������ѵ����ת��ʹ��princomp
tic %��ʱ��ʼ
for i=1:60000 %����100�Ž���ѵ��
    train_img=train_x(:,:,i);
    train_img=im2bw(train_img);%��ֵ��
    training_samples=[training_samples;train_img(:)'];%�����ּ�����train_samples��,һ�б�ʾһ�����ľ���
    find_y=find(train_y(:,i,1));
    x=i
    if find_y==10
        find_y=0;
    end
    train_label=[train_label;find_y];%�����ּ����б�ǣ�������������ʽ����
end
training_samples=double(training_samples); %һ��Ҫת��double����
mu=mean(training_samples);
%%%��ʱtraining_samples�����һ�б�ʾ����һ�����֣���Ӧ��Ҳ��train_label�������
%%%���ϼ��Ǵ�ͼƬ�����Ӧ���ֱ�ǩ
%%%���϶���û�������

%���Գ��򣬿�ɾ
% training_samples
% [sx,sy]=size(training_samples)
%��ɾ

[train_coeff,train_scores,train_latent,train_tsquare]=princomp(training_samples,'econ');% pca
%��ɾ
% train_coeff
% train_scores
% train_latent
% train_tsquare
% [x1,y1]=size(train_coeff)
% [x2,y2]=size(train_scores)
% [x3,y3]=size(train_latent)
% [x4,y4]=size(train_tsquare)
%��ɾ
%%%princomp�������
%COEFF��X��������Ӧ��Э������V����������������ɵľ��󣬼��任������ͶӰ����COEFFÿ�ж�Ӧһ������ֵ�������������е�����˳���ǰ�����ֵ�Ĵ�С�ݼ�����
%���ص�SCORE�Ƕ����ֵĴ�֣�Ҳ����˵ԭX���������ɷֿռ�ı�ʾ��SCOREÿ�ж�Ӧ�����۲�ֵ��ÿ�ж�Ӧһ�����ɷ�(����)�������к��е���Ŀ��X��������Ŀ��ͬ��
%���ص�latent��һ������������X����Ӧ��Э������������ֵ������
%���ص�tsquare���Ǳ�ʾ��ÿ��������Hotelling��T��ͳ����
%��ά��p������������n��ʱ����[...] = princomp(X,'econ')�����㣬������������߼����ٶ�
%Ҫʹ��cumsum(latent)./sum(latent)�ܹ�����98%,�ﵽ��ά��Ч��

%����ĳЩԭ��ò����pca�������ʹ�õĲ���Ƶ�����ȷ���ֱ��ʹ�����������ת��ʹ��princomp�����������pca�㷨��ʵ��
% [train_coeff,train_scores,~,~,train_explained,mu]=pca(training_samples);% pca
%%%pca��������
%[coeff,score,latent,tsquared,explained,mu]=pca(x)
%����x�����ݼ����þ����ʾ����һ��������������ʾ����������
%coeff��ʾ����ΪX����Ӧ��Э������������ֵ����
%���ص�SCORE�Ƕ����ֵĴ�֣�Ҳ����˵ԭX���������ɷֿռ�ı�ʾ��SCOREÿ�ж�Ӧ�����۲�ֵ��ÿ�ж�Ӧһ�����ɷ�(����)�������к��е���Ŀ��X��������Ŀ��ͬ��
%latentΪ����ֵ��ɵ�����
%tsquared��ʾ������T��ͳ��ֵ
%

train_idx=find(cumsum(train_latent)/sum(train_latent)>0.9,1)%idxΪǰk������������explained����ֵ
%cumsumĬ�϶�����ͣ������������ֱ����ͼ���
%ѡ������ֵ����90%��ǰtrain_idx��
%���н�ά

train_coeff=train_coeff(:,1:train_idx);%ͶӰ���� %ȡ��train_coffee��һ�е���idx�е�����
train_img_arr=train_scores(:,1:train_idx);%����������ѵ����������


% %SVMѵ��
model=svmtrain(train_label,train_img_arr,'-s 0 -s 1.5 -t 0 -g 3');
save('F:\����\����ý�弼������\MATLAB\practice\handwrite_model_60000','model');%����ѵ���õ�svmģ��
xlswrite('F:\����\����ý�弼������\MATLAB\practice\train_coeff_60000.xlsx',train_coeff); %������������
mu_1=mu';%��Ȼд����ȥ,�ᱨ��
xlswrite('F:\����\����ý�弼������\MATLAB\practice\mu_60000.xlsx',mu_1);%��������ƽ��ֵ�����������в��Ե�ʱ����õ�


% %��������
% test_img1=test_x(:,:,199);
% imshow(test_img1);
% test_img1=double(test_img1);
% test_img1=im2bw(test_img1);

% %�Լ�����д����
% test_img1=importdata('F:\����\����ý�弼������\MATLAB\practice\store\����ʶ��ľ���\number2_4')
% test_img1=imresize(test_img1,[28,28]);
% 
% %test_img1(:)' %��ʾһ��
% test_img2=test_img1(:)'- mu %mu��ʾ����training_samples��ƽ��ֵ %ʶ���ʸ���
% test_img=test_img1(:)'
% test_img_arr=test_img2*train_coeff;
% [predict_label] =svmpredict(1,test_img_arr, model); 
% predict_label
toc
 
 
 
 

