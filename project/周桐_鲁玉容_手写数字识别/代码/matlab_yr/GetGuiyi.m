% ss_22=strcat('F:\����\����ý�弼������\MATLAB\practice\store\number1_','6');
% a=importdata(ss_22)
% x=4;y=4;
% 
% subplot(x,y,1);
% imshow(a);
% title('ԭͼ');
% 
% [r,c]=size(a);
% rate=32*32/(r*c);
% b=imresize(a,rate);%�ȱ����任
% subplot(x,y,2);
% imshow(b);
% title('�ȱ����任���');
% 
% subplot(x,y,3);
% d=imresize(a,[32,32],'nearest')
% imshow(d);
% title('����ڲ�ֵ���')
% 
% subplot(x,y,4);
% e=imresize(a,[16,16],'bilinear')
% imshow(e);
% title('˫���Բ�ֵ���')
% 
% subplot(x,y,5);
% f=imresize(a,[16,16],'bicubic')
% imshow(f);
% title('˫���β�ֵ���')
% 
% subplot(x,y,6);
% g=bwmorph(d,'bridge',inf);
% imshow(g);
% title('����ڲ�ֵ����Ż�bridge')
% 
% subplot(x,y,7);
% h=bwmorph(g,'fill',inf);
% imshow(h);
% title('����ڲ�ֵ����Ż�thin')
% 
% subplot(x,y,8);
% i=bwmorph(h,'thin',inf);
% imshow(i);
% title('����ڲ�ֵ����Ż�thin')
function guiyi=GetGuiyi(I)%������Ǿ����������32*32�ľ�����������Ĺ�һ������
n=28;
[r,c]=size(I);%��ȡ����ĳ������ڽ��þ������ϴ�ķ�Χ��
bian_max=max(r,c);%��ȡ��������ֵ
bian_more=bian_max*1.5;

r_1=floor(bian_more);
c_1=floor(bian_more);
m=zeros(r,c_1);
start=floor((c_1-c)/2);
over=start+c-1;
m(:,start:over)=I;%������һ��,���

m_1=zeros(r_1,c_1);
start_1=floor((r_1-r)/2)+2;
over_1=start_1+r-1;
m_1(start_1:over_1,:)=m;%������һ�����߶�

f=m_1;
%3 2 2������
%4 3 2
%5 4 5
%3 1 1
% f=imadjust(f,[0 1],[1 0]); %�Ҷ�ӳ��
SE=strel('square',4);  %%���͡���ʴ������  %����5*5��������
A2=imdilate(f,SE); %����
SE=strel('disk',3); %�����뾶Ϊ3��Բ��
f=imerode(A2,SE);  %��ʴ
SE=strel('disk',2); %�����뾶Ϊ3��������
f=imdilate(f,SE); %�ٴ�����
gray_level=graythresh(f);%�Զ�ȷ����ֵ����ֵ
f=im2bw(f,gray_level);%��ͼ���ֵ��
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


% I_bridge=bwmorph(I,'bridge',inf);%����
% I_fill=bwmorph(I_bridge,'fill',inf);%���
% I_nearest=bwmorph(I_nearest,'thin','inf');%ϸ��

% guiyi=I_thin;
guiyi=I_nearest;
end
