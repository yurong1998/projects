test_x=importdata('F:\大三\数字媒体技术导论\MATLAB\practice\test_x.mat');
test_y=importdata('F:\大三\数字媒体技术导论\MATLAB\practice\test_y.mat');

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
    test_label=[test_label;find_y];%对数字集进行标记，以列向量的形式呈现
end

for i=1:num_test %确定输入
    test_img=test_x(:,:,i);
    test_img=im2bw(test_img);
    test_samples=[test_samples,test_img(:)];%将数字集并入test_samples里,一行表示一个数的矩阵 ,先按列读取每一张图，把每张图的像素按列排
end
test_samples=double(test_samples); %一定要转成double类型
test_out=sim(net,test_samples)%神经网络的仿真
max_value=max(test_out)%输出神经元的最大值
test_out=compet(test_out)
number=rem(find(test_out==1),10) %数字识别结果 %按列存储
j=0;
for i=1:num_test
    if number(i,1)==test_label(i,1)
        j=j+1
    end
end

num_same=j
accuracy=num_same/num_test
