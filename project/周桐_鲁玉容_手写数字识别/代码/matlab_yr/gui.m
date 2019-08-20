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
%����Ҫ����ʶ���ͼƬ
[filename,pathname] = uigetfile({'*.*';'*.jpg';'*.bmp';'*.gif';'*.png';'*.tif'},'install picture');
global str; %gobal��ʾȫ�ֱ���
str= [pathname filename];%�Ƕ�Ӧ·���µĶ�ӦͼƬ
global h1;
%������Ŀ
global gui_x;
global gui_y;
gui_x=4;
gui_y=4;
h1=subplot(gui_x,gui_y,1);%3��4�е�һ��ͼ
if ~isequal([pathname,filename],[0,0])%·���Ƿ���ȷ
    x = imread(str);%src_img�����ж�Ӧ�ľ���ֵ
    imshow(x);
end





% --------------------------------------------------------------------
function erzhihua_Callback(hObject, eventdata, handles)
% hObject    handle to erzhihua (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%ʹ�������䷽��ҵ�ͼƬ��һ�����ʵ���ֵ


% --- Executes on button press in black_white.
function black_white_Callback(hObject, eventdata, handles)
% hObject    handle to black_white (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%����Ҫ����ʶ���ͼƬ
%[filename,pathname] = uigetfile({'*.*';'*.jpg';'*.bmp';'*.gif';'*.png';'*.tif'},'install picture');
%str = [pathname filename];%�Ƕ�Ӧ·���µĶ�ӦͼƬ
global h2;
global str;
global y_erzhi;%��ֵ��֮��ľ���
global r;%�������
global c;%�������
global gui_x;
global gui_y;
h2=subplot(gui_x,gui_y,2);%3��4�еڶ���ͼ
y = imread(str);%src_img�����ж�Ӧ�ľ���ֵ
imshow(y);
thresh=graythresh(y);%�Զ�ȷ����ֵ����ֵ
y_erzhi=im2bw(y,thresh);%��ͼ���ֵ��
[r,c]=size(y_erzhi);
fid=fopen('F:\����\����ý�弼������\MATLAB\practice\one.txt','wt');%����ֵ����ͼ����󱣴浽txt��
for i=1:r
   for j=1:c
       if y_erzhi(i,j)==1%��ͻ������Ϊ��ɫ
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


%��ʴ-����-��ʴҲ����Խ��
% %�Զ�ֵ���Ľ�����и�ʴ����%���ǽ���е㲻���룬����ɾ����ͨ���������С��һ��ֵ����ͨ����
% se1=strel('disk',1); %����һ���뾶Ϊ5��ƽ̹��Բ�̽ṹ
% fushi_1=imerode(y_erzhi,se1);%��ʴ�Ĺ���
% subplot(3,4,10);
% imshow(fushi_1);
% title('��ʴdisk(4)֮���ͼ��');
% y_erzhi=imdilate(fushi_1,se1);%��ʴ֮������
% subplot(3,4,11);
% imshow(y_erzhi);
% title('����disk(4)֮���ͼ��');



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)%��ȡ��ͨ����
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global h;
global y_erzhi;%��ֵ��֮��ľ���
global r;%�������
global c;%�������
global num_new;%������ͨ����ĸ���
[L,num]=bwlabel(y_erzhi,8);%��ȡ����ͨ����num��ʾ��ͨ����ĸ���
fid=fopen('F:\����\����ý�弼������\MATLAB\practice\two.txt','wt');%����ֵ����ͼ����󱣴浽txt��
for i=1:r
     for j=1:c
        fprintf(fid,'%d',L(i,j));
     end
        fprintf(fid,'\n');
end
fclose(fid);

areas=zeros(1,num);

for shuzi=1:num %��num����ͨ����
    
    ss=strcat('F:\����\����ý�弼������\MATLAB\practice\store\number_',int2str(shuzi));
    ss_1=strcat('F:\����\����ý�弼������\MATLAB\practice\store\number1_',int2str(shuzi));
    ff=fopen(ss,'wt');
    ff_1=fopen(ss_1,'wt');
    l=zeros(r,c);
    %��ÿһ����ͨ���򵥶��Ĵ���number_x��txt�ļ���
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
    %����ɨ�裬Ϊ���ܹ���ȡÿһ����ͨ������խ�Ĳ���
    num_qian=0;%ǰ������
    num_zhong=0;
    for i=1:c  %һ����ɨ��
      num_0=0;  %��־����Ϊ0�ĸ���
      num_other=0;  %���Ϊ1����־��������ͨ���򣻷��򣬷�֮
      num_tiao=0;
      for j=1:r
         if l(j,i)==1
             num_other=1;%��־��������ͨ����
         elseif l(j,i)~=1
             num_0=num_0+1;
         end
      end
      if num_other==1
         num_zhong=num_zhong+1; %������ͨ����Ŀ��
      elseif num_0>1&&num_zhong==0%�����ȫ��0
         num_qian=num_qian+1; %��ͨ����ǰ���ж����ж��ǲ���Ҫ�ģ�����ģ���ʡȥ��
      else
         num_tiao=1; %��ʾ�Ѿ������ͨ���򣬿�������ѭ����
      end
    
      if num_tiao==1
         break;
      end
    end
    
    %����ɨ�裬Ϊ���ܹ���ȡÿһ����ͨ�������Ĳ���
    num_up=0;%ǰ������
    num_middle=0;
    for i=1:r  %һ����ɨ��
      %��ʼ����־λ
      
      num_0=0;  %��־����Ϊ0�ĸ���
      num_other=0;  %���Ϊ1����־��������ͨ���򣻷��򣬷�֮
      num_tiao=0;
      for j=1:c
         if l(i,j)==1
             num_other=1;%��־��������ͨ����
         elseif l(i,j)~=1
             num_0=num_0+1;
         end
      end
      if num_other==1
         num_middle=num_middle+1; %������ͨ����ĸ߶�
      elseif num_0>1&&num_middle==0%�����ȫ��0
         num_up=num_up+1; %��ͨ���������ж����ж��ǲ���Ҫ�ģ�����ģ���ʡȥ��
      else
         num_tiao=1; %��ʾ�Ѿ������ͨ���򣬿�������ѭ����
      end
    
      if num_tiao==1
         break;
      end
    end
    
    ll=zeros(num_middle,num_zhong);%����һ��Ԫ��ȫ��0�ľ�������װÿһ������
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
    %��ÿһ����ͨ�������������
    area=regionprops(ll,'Area')
    areas(shuzi)=area(1).Area
end

clc;
%��Ҫȥ����Щ�����С����ͨ����
% �������ƽ��ֵ
areas
pingjun=fix(mean(areas))
fangcha=fix(var(areas))
biaozhun=sqrt(fangcha)
jishu=0;
gui_x=4;
gui_y=4;
for s=1:num
    ss_22=strcat('F:\����\����ý�弼������\MATLAB\practice\store\number1_',int2str(s));
    a=importdata(ss_22);%����a�������Ƕ�Ӧ����ͨ�������ڵľ���
    [r,c]=size(a);
    if areas(s)>pingjun-biaozhun/2 %ȥ����Щ���С�ڣ�ƽ��ֵ-��׼��/2���Ĳ��֣������ݶ�������������������Ļ�������Щ���ֿ��Կ����ǵ�����������
        jishu=jishu+1;
        ss_3=strcat('F:\����\����ý�弼������\MATLAB\practice\store\number2_',int2str(jishu));
        ff=fopen(ss_3,'wt');
        a=GetGuiyi(a);%��һ������
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
%ʶ��
% global num_new;%������ͨ����ĸ���
% predict_nums=[];
% for i=1:num_new
%     numbers=strcat('F:\����\����ý�弼������\MATLAB\practice\store\number2_',int2str(i));
%     num=importdata(numbers);
%     predict_nums(i)=predict_svm(num)
% end
% num=num2str(predict_nums)
% msgbox(num, 'ʶ����');

global num_new;%������ͨ����ĸ���
gui_x=4;
gui_y=4;
imgs=[];
num_new
predict_nums=[];
%%pca,svmʶ������
for i=1:num_new
    numbers=strcat('F:\����\����ý�弼������\MATLAB\practice\store\number2_',int2str(i));
    num=importdata(numbers);
    num=double(num);
    imgs(:,:,i)=num
%     subplot(gui_x,gui_y,i+2);
%     imshow(num);
%     predict_nums(i)=predict_svm(num)
end
num_predict=predict_svm(imgs,num_new)

% num=num2str(predict_nums)
msgbox(num_predict, 'ʶ����');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global num_new;%������ͨ����ĸ���
gui_x=4;
gui_y=4;
imgs=[];
num_new
predict_nums=[];

%%bp������ʶ��
for i=1:num_new
    numbers=strcat('F:\����\����ý�弼������\MATLAB\practice\store\number2_',int2str(i));
    num=importdata(numbers);
    num=double(num);
    imgs(:,:,i)=num
%     subplot(gui_x,gui_y,i+2);
%     imshow(num);
%     predict_nums(i)=predict_svm(num)
end
num_predict=bp_rec(imgs,num_new)
% num=num2str(predict_nums)
msgbox(num_predict, 'ʶ����');