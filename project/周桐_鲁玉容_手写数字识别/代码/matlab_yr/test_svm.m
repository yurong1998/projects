%test_svm�Ľ��
train_coeff=xlsread('F:\����\����ý�弼������\MATLAB\practice\train_coeff_60000.xlsx');%��ȡ��Ӧ�洢����������
mu=xlsread('F:\����\����ý�弼������\MATLAB\practice\mu_60000.xlsx');%��ȡ��Ӧ��ƽ��training_samples��ѵ������ƽ��ֵ,�����������ʵ�Ѿ�ת����
model=importdata('F:\����\����ý�弼������\MATLAB\practice\handwrite_model_60000.mat');%��ȡѵ���õ�model

mu=mu';
%�κ�����ѵ��������ѵ��60000��ͼƬ

%������Լ�test.x & test.y
test_x=importdata('F:\����\����ý�弼������\MATLAB\practice\test_x.mat');
test_y=importdata('F:\����\����ý�弼������\MATLAB\practice\test_y.mat');

test_samples=[]; %���Ծ���
test_label=[]; %���Ա�ǩ,����Ϊѵ���ı�ǩָ�ľ��Ƕ�Ӧ������

%��matlab�Դ���pca�������в��ԣ�ת��ʹ��princomp
tic %��ʱ��ʼ
for i=1:10000 
    find_y=find(test_y(:,i,1));
    x=i
    if find_y==10
        find_y=0;
    end
    test_label=[test_label;find_y];%�����ּ����б�ǣ�������������ʽ����
end

imgs=test_x;
num_new=1000
nums=[];%�洢�õ�����������
num_true=0;
for i=1:num_new
    img=imgs(:,:,i);
    img=im2bw(img);%��ֵ������
    test_img2=img(:)'- mu; %mu��ʾ����training_samples��ƽ��ֵ %ʶ���ʸ���
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
 
 
 
 

