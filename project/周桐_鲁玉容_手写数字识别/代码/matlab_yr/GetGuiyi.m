% ss_22=strcat('F:\大三\数字媒体技术导论\MATLAB\practice\store\number1_','6');
% a=importdata(ss_22)
% x=4;y=4;
% 
% subplot(x,y,1);
% imshow(a);
% title('原图');
% 
% [r,c]=size(a);
% rate=32*32/(r*c);
% b=imresize(a,rate);%等比例变换
% subplot(x,y,2);
% imshow(b);
% title('等比例变换结果');
% 
% subplot(x,y,3);
% d=imresize(a,[32,32],'nearest')
% imshow(d);
% title('最近邻差值结果')
% 
% subplot(x,y,4);
% e=imresize(a,[16,16],'bilinear')
% imshow(e);
% title('双线性差值结果')
% 
% subplot(x,y,5);
% f=imresize(a,[16,16],'bicubic')
% imshow(f);
% title('双三次差值结果')
% 
% subplot(x,y,6);
% g=bwmorph(d,'bridge',inf);
% imshow(g);
% title('最近邻差值结果优化bridge')
% 
% subplot(x,y,7);
% h=bwmorph(g,'fill',inf);
% imshow(h);
% title('最近邻差值结果优化thin')
% 
% subplot(x,y,8);
% i=bwmorph(h,'thin',inf);
% imshow(i);
% title('最近邻差值结果优化thin')
function guiyi=GetGuiyi(I)%传入的是矩阵，输出的是32*32的矩阵，如此所述的归一化操作
n=28;
[r,c]=size(I);%获取矩阵的长宽，便于将该矩阵放入较大的范围内
bian_max=max(r,c);%获取长宽的最大值
bian_more=bian_max*1.5;

r_1=floor(bian_more);
c_1=floor(bian_more);
m=zeros(r,c_1);
start=floor((c_1-c)/2);
over=start+c-1;
m(:,start:over)=I;%扩大了一倍,宽度

m_1=zeros(r_1,c_1);
start_1=floor((r_1-r)/2)+2;
over_1=start_1+r-1;
m_1(start_1:over_1,:)=m;%扩大了一倍，高度

f=m_1;
%3 2 2还可以
%4 3 2
%5 4 5
%3 1 1
% f=imadjust(f,[0 1],[1 0]); %灰度映射
SE=strel('square',4);  %%膨胀、腐蚀、膨胀  %创建5*5的正方形
A2=imdilate(f,SE); %膨胀
SE=strel('disk',3); %创建半径为3的圆盘
f=imerode(A2,SE);  %腐蚀
SE=strel('disk',2); %创建半径为3的正方形
f=imdilate(f,SE); %再次膨胀
gray_level=graythresh(f);%自动确定二值化阈值
f=im2bw(f,gray_level);%对图像二值化
m_1=f;

e=imresize(m_1,[28,28],'bilinear');
for i=1:28
   for j=1:28
    if e(i,j)>0.1
        e_1(i,j)=1;
    else
        e_1(i,j)=0;
    end
   end
end
I_nearest=e_1;
% I_nearest=imresize(I,[n,n],'nearest');


% I_bridge=bwmorph(I,'bridge',inf);%连接
% I_fill=bwmorph(I_bridge,'fill',inf);%填充
% I_nearest=bwmorph(I_nearest,'thin','inf');%细化

% guiyi=I_thin;
guiyi=I_nearest;
end
