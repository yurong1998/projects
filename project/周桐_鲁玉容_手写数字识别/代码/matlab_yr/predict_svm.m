% function predict_num=predict_svm(img)
% %ʶ����
% 
% train_coeff=xlsread('F:\����\����ý�弼������\MATLAB\practice\train_coeff_60000.xlsx');%��ȡ��Ӧ�洢����������
% mu=xlsread('F:\����\����ý�弼������\MATLAB\practice\mu_60000.xlsx');%��ȡ��Ӧ��ƽ��training_samples��ѵ������ƽ��ֵ,�����������ʵ�Ѿ�ת����
% model=importdata('F:\����\����ý�弼������\MATLAB\practice\handwrite_model_60000.mat');%��ȡѵ���õ�model
% 
% %�Լ�����д����
% %img
% mu=mu';
% %test_img1(:)' %��ʾһ��
% test_img2=img(:)'- mu %mu��ʾ����training_samples��ƽ��ֵ %ʶ���ʸ���
% test_img_arr=test_img2*train_coeff;
% [predict_label] =svmpredict(1,test_img_arr, model); 
% predict_num=predict_label;
% end
%������һ������һ������ʶ��
function predict_num=predict_svm(imgs,num_new)
%ʶ����

train_coeff=xlsread('F:\����\����ý�弼������\MATLAB\practice\train_coeff_60000.xlsx');%��ȡ��Ӧ�洢����������
mu=xlsread('F:\����\����ý�弼������\MATLAB\practice\mu_60000.xlsx');%��ȡ��Ӧ��ƽ��training_samples��ѵ������ƽ��ֵ,�����������ʵ�Ѿ�ת����
model=importdata('F:\����\����ý�弼������\MATLAB\practice\handwrite_model_60000.mat');%��ȡѵ���õ�model

%�Լ�����д����
%img
mu=mu';
%test_img1(:)' %��ʾһ��

nums=[];%�洢�õ�����������
for i=1:num_new
    img=imgs(:,:,i);
    imshow(img)
    test_img2=img(:)'- mu; %mu��ʾ����training_samples��ƽ��ֵ %ʶ���ʸ���
    test_img_arr=test_img2*train_coeff;
    [predict_label] =svmpredict(1,test_img_arr, model); 
    nums(i)=predict_label
end
predict_num=num2str(nums)
end
 
 
 
 


