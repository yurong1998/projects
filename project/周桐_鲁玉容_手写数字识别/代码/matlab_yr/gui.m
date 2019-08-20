function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 18-Dec-2018 14:53:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function install_Callback(hObject, eventdata, handles)
% hObject    handle to install (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%导入要进行识别的图片
[filename,pathname] = uigetfile({'*.*';'*.jpg';'*.bmp';'*.gif';'*.png';'*.tif'},'install picture');
global str; %gobal表示全局变量
str= [pathname filename];%是对应路径下的对应图片
global h1;
%行列数目
global gui_x;
global gui_y;
gui_x=4;
gui_y=4;
h1=subplot(gui_x,gui_y,1);%3行4列第一张图
if ~isequal([pathname,filename],[0,0])%路径是否正确
    x = imread(str);%src_img里面有对应的矩阵值
    imshow(x);
end





% --------------------------------------------------------------------
function erzhihua_Callback(hObject, eventdata, handles)
% hObject    handle to erzhihua (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%使用最大类间方差法找到图片的一个合适的阈值


% --- Executes on button press in black_white.
function black_white_Callback(hObject, eventdata, handles)
% hObject    handle to black_white (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%导入要进行识别的图片
%[filename,pathname] = uigetfile({'*.*';'*.jpg';'*.bmp';'*.gif';'*.png';'*.tif'},'install picture');
%str = [pathname filename];%是对应路径下的对应图片
global h2;
global str;
global y_erzhi;%二值化之后的矩阵
global r;%矩阵的行
global c;%矩阵的列
global gui_x;
global gui_y;
h2=subplot(gui_x,gui_y,2);%3行4列第二张图
y = imread(str);%src_img里面有对应的矩阵值
imshow(y);
thresh=graythresh(y);%自动确定二值化阈值
y_erzhi=im2bw(y,thresh);%对图像二值化
[r,c]=size(y_erzhi);
fid=fopen('F:\大三\数字媒体技术导论\MATLAB\practice\one.txt','wt');%将二值化的图像矩阵保存到txt中
for i=1:r
   for j=1:c
       if y_erzhi(i,j)==1%让突出数字为白色
           y_erzhi(i,j)=0;
       else
           y_erzhi(i,j)=1;
       end
     fprintf(fid,'%d',y_erzhi(i,j));
   end
     fprintf(fid,'\n');
end
fclose(fid);
imshow(y_erzhi);


%腐蚀-膨胀-腐蚀也许可以解决
% %对二值化的结果进行腐蚀膨胀%但是结果有点不理想，考虑删除连通区域中面积小于一定值的连通区域
% se1=strel('disk',1); %创建一个半径为5的平坦型圆盘结构
% fushi_1=imerode(y_erzhi,se1);%腐蚀的过程
% subplot(3,4,10);
% imshow(fushi_1);
% title('腐蚀disk(4)之后的图像');
% y_erzhi=imdilate(fushi_1,se1);%腐蚀之后膨胀
% subplot(3,4,11);
% imshow(y_erzhi);
% title('膨胀disk(4)之后的图像');



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)%提取连通区域
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global h;
global y_erzhi;%二值化之后的矩阵
global r;%矩阵的行
global c;%矩阵的列
global num_new;%数字连通区域的个数
[L,num]=bwlabel(y_erzhi,8);%提取八连通区域，num表示连通区域的个数
fid=fopen('F:\大三\数字媒体技术导论\MATLAB\practice\two.txt','wt');%将二值化的图像矩阵保存到txt中
for i=1:r
     for j=1:c
        fprintf(fid,'%d',L(i,j));
     end
        fprintf(fid,'\n');
end
fclose(fid);

areas=zeros(1,num);

for shuzi=1:num %有num个连通区域
    
    ss=strcat('F:\大三\数字媒体技术导论\MATLAB\practice\store\number_',int2str(shuzi));
    ss_1=strcat('F:\大三\数字媒体技术导论\MATLAB\practice\store\number1_',int2str(shuzi));
    ff=fopen(ss,'wt');
    ff_1=fopen(ss_1,'wt');
    l=zeros(r,c);
    %将每一个连通区域单独的存入number_x的txt文件中
    for i=1:r
      for j=1:c
         if L(i,j)==shuzi
             l(i,j)=1;
             fprintf(ff,'%d',l(i,j));
         else
             l(i,j)=0;
             fprintf(ff,'%d',l(i,j));
         end
     end
        fprintf(ff,'\n');
    end
    fclose(ff);
    %竖着扫描，为了能够截取每一个连通区域最窄的部分
    num_qian=0;%前面多余的
    num_zhong=0;
    for i=1:c  %一列列扫描
      num_0=0;  %标志该列为0的个数
      num_other=0;  %如果为1，标志此列有连通区域；否则，反之
      num_tiao=0;
      for j=1:r
         if l(j,i)==1
             num_other=1;%标志此列有连通区域
         elseif l(j,i)~=1
             num_0=num_0+1;
         end
      end
      if num_other==1
         num_zhong=num_zhong+1; %计算连通区域的宽度
      elseif num_0>1&&num_zhong==0%如果列全是0
         num_qian=num_qian+1; %连通区域前面有多少列都是不需要的，多余的，可省去的
      else
         num_tiao=1; %表示已经跨过连通区域，可以跳出循环了
      end
    
      if num_tiao==1
         break;
      end
    end
    
    %横着扫描，为了能够截取每一个连通区域最扁的部分
    num_up=0;%前面多余的
    num_middle=0;
    for i=1:r  %一行行扫描
      %初始化标志位
      
      num_0=0;  %标志该列为0的个数
      num_other=0;  %如果为1，标志此列有连通区域；否则，反之
      num_tiao=0;
      for j=1:c
         if l(i,j)==1
             num_other=1;%标志此列有连通区域
         elseif l(i,j)~=1
             num_0=num_0+1;
         end
      end
      if num_other==1
         num_middle=num_middle+1; %计算连通区域的高度
      elseif num_0>1&&num_middle==0%如果行全是0
         num_up=num_up+1; %连通区域上面有多少列都是不需要的，多余的，可省去的
      else
         num_tiao=1; %表示已经跨过连通区域，可以跳出循环了
      end
    
      if num_tiao==1
         break;
      end
    end
    
    ll=zeros(num_middle,num_zhong);%创建一个元素全是0的矩阵用来装每一个分区
    for i=1:num_middle
      for j=1:num_zhong
         if l(i+num_up,j+num_qian)==1
             ll(i,j)=1;
             fprintf(ff_1,'%d ',ll(i,j));
         elseif l(i+num_up,j+num_qian)==0
             ll(i,j)=0;
             fprintf(ff_1,'%d ',ll(i,j));
         end
      end
         fprintf(ff_1,'\n');
    end
    fclose(ff_1);
    %将每一个连通区域的面积求出来
    area=regionprops(ll,'Area')
    areas(shuzi)=area(1).Area
end

clc;
%需要去除那些面积过小的连通区域
% 求面积的平均值
areas
pingjun=fix(mean(areas))
fangcha=fix(var(areas))
biaozhun=sqrt(fangcha)
jishu=0;
gui_x=4;
gui_y=4;
for s=1:num
    ss_22=strcat('F:\大三\数字媒体技术导论\MATLAB\practice\store\number1_',int2str(s));
    a=importdata(ss_22);%矩阵a里面存的是对应的连通区域所在的矩阵
    [r,c]=size(a);
    if areas(s)>pingjun-biaozhun/2 %去除那些面积小于（平均值-标准差/2）的部分，现在暂定是这样，如果不成立的话，则那些部分可以看做是单独的数字了
        jishu=jishu+1;
        ss_3=strcat('F:\大三\数字媒体技术导论\MATLAB\practice\store\number2_',int2str(jishu));
        ff=fopen(ss_3,'wt');
        a=GetGuiyi(a);%归一化操作
        [r,c]=size(a);
        for i=1:r
           for j=1:c
                fprintf(ff,'%d ',a(i,j));
           end
           fprintf(ff,'\n');
        end
        areas(s)
        subplot(gui_x,gui_y,jishu+2);
        imshow(a);
    end
    num_new=jishu;
end

    
    
    
    


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%识别
% global num_new;%数字连通区域的个数
% predict_nums=[];
% for i=1:num_new
%     numbers=strcat('F:\大三\数字媒体技术导论\MATLAB\practice\store\number2_',int2str(i));
%     num=importdata(numbers);
%     predict_nums(i)=predict_svm(num)
% end
% num=num2str(predict_nums)
% msgbox(num, '识别结果');

global num_new;%数字连通区域的个数
gui_x=4;
gui_y=4;
imgs=[];
num_new
predict_nums=[];
%%pca,svm识别如下
for i=1:num_new
    numbers=strcat('F:\大三\数字媒体技术导论\MATLAB\practice\store\number2_',int2str(i));
    num=importdata(numbers);
    num=double(num);
    imgs(:,:,i)=num
%     subplot(gui_x,gui_y,i+2);
%     imshow(num);
%     predict_nums(i)=predict_svm(num)
end
num_predict=predict_svm(imgs,num_new)

% num=num2str(predict_nums)
msgbox(num_predict, '识别结果');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global num_new;%数字连通区域的个数
gui_x=4;
gui_y=4;
imgs=[];
num_new
predict_nums=[];

%%bp神经网络识别
for i=1:num_new
    numbers=strcat('F:\大三\数字媒体技术导论\MATLAB\practice\store\number2_',int2str(i));
    num=importdata(numbers);
    num=double(num);
    imgs(:,:,i)=num
%     subplot(gui_x,gui_y,i+2);
%     imshow(num);
%     predict_nums(i)=predict_svm(num)
end
num_predict=bp_rec(imgs,num_new)
% num=num2str(predict_nums)
msgbox(num_predict, '识别结果');