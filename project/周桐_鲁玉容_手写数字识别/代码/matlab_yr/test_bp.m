test_x=importdata('F:\����\����ý�弼������\MATLAB\practice\test_x.mat');
test_y=importdata('F:\����\����ý�弼������\MATLAB\practice\test_y.mat');

load bp_10000 net
test_label=[];
test_samples=[];
num_test=10000;


for i=1:num_test
    find_y=find(test_y(:,i,1));
    x=i
    if find_y==10
        find_y=0;
    end
    test_label=[test_label;find_y];%�����ּ����б�ǣ�������������ʽ����
end

for i=1:num_test %ȷ������
    test_img=test_x(:,:,i);
    test_img=im2bw(test_img);
    test_samples=[test_samples,test_img(:)];%�����ּ�����test_samples��,һ�б�ʾһ�����ľ��� ,�Ȱ��ж�ȡÿһ��ͼ����ÿ��ͼ�����ذ�����
end
test_samples=double(test_samples); %һ��Ҫת��double����
test_out=sim(net,test_samples)%������ķ���
max_value=max(test_out)%�����Ԫ�����ֵ
test_out=compet(test_out)
number=rem(find(test_out==1),10) %����ʶ���� %���д洢
j=0;
for i=1:num_test
    if number(i,1)==test_label(i,1)
        j=j+1
    end
end

num_same=j
accuracy=num_same/num_test
