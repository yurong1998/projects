clear;clc;
%����

%����ѵ����train.x & train.y
train_x=importdata('F:\����\����ý�弼������\MATLAB\practice\������\train_x.mat');
train_y=importdata('F:\����\����ý�弼������\MATLAB\practice\������\train_y.mat');
test_x=importdata('F:\����\����ý�弼������\MATLAB\practice\������\test_x.mat');

training_samples=[]; %ѵ������
train_label=[]; %ѵ����ǩ,����Ϊѵ���ı�ǩָ�ľ��Ƕ�Ӧ������
test_samples=[];

num=10000;
train_label=train_y(:,1:num,1);%����ԭʼ���ݶ��룬һ��10�б�ʾһ��������i��Ϊ1���������Ϊi,10��Ӧ0
train_label=double(train_label);


tic %��ʱ��ʼ
for i=1:num %ȷ������
    train_img=train_x(:,:,i);
    train_img=im2bw(train_img);%��ֵ��
    training_samples=[training_samples,train_img(:)];%�����ּ�����train_samples��,һ�б�ʾһ�����ľ��� ,�Ȱ��ж�ȡÿһ��ͼ����ÿ��ͼ�����ذ�����
end
training_samples=double(training_samples); %һ��Ҫת��double����
%������Ϊ���ﲻ��Ҫ��һ������Ϊ������Ǵ���0,1��������
%������Ԫȡ70������ѵģ�

%����ǰ��bp�����纯��
net=newff(minmax(training_samples),[784 70 10],{'logsig','logsig','logsig'},'traincgb');
%training_samplesΪѵ����������
%[784 70 10]Ϊ������Ĳ�ṹ
%{'logsig','logsig','logsig'}Ϊ������ĸ����ת�ƺ�����������Ϊ����S�ͼ����
%ѵ����������'traincgb'�������ù����ݶȷ�ѵ��

net.trainParam.epichs=1000;%���ѵ������
net.trainParam.show=20; %��ʾ�ļ������
net.trainParam.min_grad=1e-10; %��Сִ���ݶ�
net.performFcn='sse'; %����Ŀ�����ܺ���
net.trainParam.goal=0.01; %��������Ŀ��ֵ
net.layers{1}.initFcn='initwb';%�����ĳ�ʼ������Ϊ'initwb'
net.inputWeights{1,1}.initFcn='randnr'; %�����Ȩֵ������ʼ��
net.inputWeights{2,1}.initFcn='randnr'; %��1����㵽��2������Ȩֵ������ʼ��
net=init(net); %��ʼ������
[net,tr]=train(net,training_samples,train_label);

save bp_10000 net 
% num_test=5;
% for i=1:num_test %ȷ������
%     test_img=test_x(:,:,i);
%     test_img=im2bw(test_img);%��ֵ��
%     test_samples=[test_samples,test_img(:)];%�����ּ�����test_samples��,һ�б�ʾһ�����ľ��� ,�Ȱ��ж�ȡÿһ��ͼ����ÿ��ͼ�����ذ�����
% end
% test_samples=double(test_samples); %һ��Ҫת��double����
% test_out=sim(net,test_samples);%������ķ���
% max_value=max(testout);%�����Ԫ�����ֵ
% if(max_value>0.7) %�����Ԫ�����ֵ����0.7�Ž�������ʶ��С��0.7ʱ�ܾ�ʶ��
%     testout=compet(testout);
%     number=find(testout==1)-1 %����ʶ����
% end

toc
 
 
 
 

