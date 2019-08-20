function result=bp_rec(imgs,num)
% for i=1:10
%     numbers=strcat('F:\大三\数字媒体技术导论\MATLAB\practice\store\number2_',int2str(i));
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
for i=1:num_test %确定输入
    test_img=test_x(:,:,i);
%     test_img=im2bw(test_img);%二值化
    test_samples=[test_samples,test_img(:)];%将数字集并入test_samples里,一行表示一个数的矩阵 ,先按列读取每一张图，把每张图的像素按列排
end
test_samples=double(test_samples); %一定要转成double类型
test_out=sim(net,test_samples)%神经网络的仿真
max_value=max(test_out)%输出神经元的最大值
% if(max_value>0.7) %输出神经元的最大值大于0.7才进行数字识别，小于0.7时拒绝识别
%     test_out=compet(test_out);
%     number=rem(find(test_out==1),10); %数字识别结果
%     result=number';
% end
test_out=compet(test_out)
number=rem(find(test_out==1),10) %数字识别结果
result=number'
result=num2str(result)
end