function result=bp_rec(imgs,num)
% for i=1:10
%     numbers=strcat('F:\����\����ý�弼������\MATLAB\practice\store\number2_',int2str(i));
%     num=importdata(numbers);
%     num=double(num);
%     imgs(:,:,i)=num
% %     subplot(gui_x,gui_y,i+2);
% %     imshow(num);
% %     predict_nums(i)=predict_svm(num)
% end
load bp_10000 net
test_x=imgs;
test_samples=[];
num_test=num;
for i=1:num_test %ȷ������
    test_img=test_x(:,:,i);
%     test_img=im2bw(test_img);%��ֵ��
    test_samples=[test_samples,test_img(:)];%�����ּ�����test_samples��,һ�б�ʾһ�����ľ��� ,�Ȱ��ж�ȡÿһ��ͼ����ÿ��ͼ�����ذ�����
end
test_samples=double(test_samples); %һ��Ҫת��double����
test_out=sim(net,test_samples)%������ķ���
max_value=max(test_out)%�����Ԫ�����ֵ
% if(max_value>0.7) %�����Ԫ�����ֵ����0.7�Ž�������ʶ��С��0.7ʱ�ܾ�ʶ��
%     test_out=compet(test_out);
%     number=rem(find(test_out==1),10); %����ʶ����
%     result=number';
% end
test_out=compet(test_out)
number=rem(find(test_out==1),10) %����ʶ����
result=number'
result=num2str(result)
end