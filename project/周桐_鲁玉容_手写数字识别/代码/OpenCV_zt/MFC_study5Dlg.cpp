
// MFC_study5Dlg.cpp: 实现文件
//

#include "stdafx.h"
#include "MFC_study5.h"
#include "MFC_study5Dlg.h"
#include "afxdialogex.h"
#include <iostream>
#include <vector>
#include <string>
using namespace std;

using namespace cv;

using namespace cv::ml;

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CMFCstudy5Dlg 对话框



CMFCstudy5Dlg::CMFCstudy5Dlg(CWnd* pParent /*=nullptr*/)
	: CDialogEx(IDD_MFC_STUDY5_DIALOG, pParent)
	, Cstr_result(_T(""))
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CMFCstudy5Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_RESULT, Cstr_result);
}

BEGIN_MESSAGE_MAP(CMFCstudy5Dlg, CDialogEx)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_OPEN, &CMFCstudy5Dlg::OnBnClickedOpen)
	ON_BN_CLICKED(IDC_IDENTIFY, &CMFCstudy5Dlg::OnBnClickedIdentify)
END_MESSAGE_MAP()


// CMFCstudy5Dlg 消息处理程序

BOOL CMFCstudy5Dlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// 设置此对话框的图标。  当应用程序主窗口不是对话框时，框架将自动
	//  执行此操作
	SetIcon(m_hIcon, TRUE);			// 设置大图标
	SetIcon(m_hIcon, FALSE);		// 设置小图标

	// TODO: 在此添加额外的初始化代码
	svm = SVM::load("mnist1.xml");//载入训练好的.xml文件
	
	return TRUE;  // 除非将焦点设置到控件，否则返回 TRUE
}

// 如果向对话框添加最小化按钮，则需要下面的代码
//  来绘制该图标。  对于使用文档/视图模型的 MFC 应用程序，
//  这将由框架自动完成。

void CMFCstudy5Dlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 用于绘制的设备上下文

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// 使图标在工作区矩形中居中
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// 绘制图标
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialogEx::OnPaint();
	}
}

//当用户拖动最小化窗口时系统调用此函数取得光标
//显示。
HCURSOR CMFCstudy5Dlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}



void CMFCstudy5Dlg::OnBnClickedOpen()
{
	// TODO: 在此添加控件通知处理程序代码
	// TODO: 在此添加控件通知处理程序代码
//	Mat src;//构造一个图像Mat类

	char path1[100];//文件路径

	CString filter;//文件过滤器，用来约束打开文件的类型
	CString path;
	filter = "All Files (*.*)|*.*|JPGtu图片(*.jpg)|*.jpg|BMP图像(*.bmp)|*.bmp|PNG图片(*.png)|*.png||";//能够打开.bmp .jpg .png的图像
	CFileDialog dlg(TRUE, NULL, NULL, OFN_HIDEREADONLY, filter);//文件对话框类：true 打开文件对话框 OFN_HIDEREADONLY文件对话框的属性，表示隐藏文件对话框上的―Read Only‖复选框  filter文件对话框中只有符合过滤条件的文件显示在文件列表中待选择。
	if (dlg.DoModal() != IDOK)
	{
		MessageBoxA(NULL, "does not chose image", "ss", IDOK);
		return;
	}
	path = dlg.GetPathName();//获得选定文件的路径全名
	path.Replace(_T("\\"), _T("\\\\"));//转移字符的转换    用\\\\来替换所有的\\为什么呢？？    
	memset(path1, 0, sizeof(path1));//将path1中所有元素清0，返回指针path1
	int k = path.GetAllocLength();//分配字符串缓冲区的大小
	for (int i = 0; path[i] != 0; i++)//要不要换成i<k
	{
		path1[i] = path[i];
	}

	src = imread(path1);//读取了path1中的图片
	if (!src.data)//如果数据为空则说明无法打开文件
	{
		MessageBoxA(NULL, "could not load picture", "ss", IDOK);
		return;
	}

	IplImage img = src;
	DrawPicToHDC(&img, IDC_SHOWIMG);//转换后直接调用就OK了！
	src = imread(path1,0);//读取了path1中的图片

}

void CMFCstudy5Dlg::DrawPicToHDC(IplImage *img, UINT ID)
{
	//设备环境对象类----CDC类。GdiObject---图形对象类  DC是设备上下文的缩写，即Device Context的简称，它实际就是与一个窗口关联的画笔，利用该画笔，即DC，可以在窗口进行图形的绘制和文字的显示
	CDC *pDC = GetDlgItem(ID)->GetDC();//GetDlgItem(ID)访问对话框中的控件,返回的是CWnd*类型的指针，是所有窗口类型的父类
	HDC hDC = pDC->GetSafeHdc();//返回输出设备上下文的句柄 Win32 编程时用HDC 来操作 绘图设备MFC中封装了HDC 但为了和Win32 兼容,	就用这个函数得到它, 以备用户操作HDC
	CRect rect;
	GetDlgItem(ID)->GetClientRect(&rect);//该函数获取窗口客户区的大小
	CvvImage cimg;

	cimg.CopyOf(img, 3);
	cimg.DrawToHDC(hDC, &rect);

	ReleaseDC(pDC);
}

//预处理 灰度化 腐蚀膨胀
void CMFCstudy5Dlg::preDealImg()
{
//	cvtColor(src, src, CV_BGR2GRAY);//将现在的彩色图片转化成灰度图片

	threshold(src, src, 100, 500.0, CV_THRESH_BINARY);//进行二值化处理，选择100，500.0为阈值

	bitwise_not(src, src);//将图像反相

//	Mat ele = getStructuringElement(MORPH_RECT, Size(1, 1));
//	erode(src, src, ele);//腐蚀

//	Mat element = getStructuringElement(MORPH_RECT, Size(7, 7));
//	dilate(src, src, element);//膨胀

	//CStatic *pPictureControl = NULL;
	//pPictureControl->Create(_T(""), WS_CHILD | WS_VISIBLE | SS_BITMAP, CRect(20, 10, 80, 40), this, 12345);
	//IplImage img = src;
	//DrawPicToHDC(&img, IDC_SHOWIMG);//转换后直接调用就OK了！

}

void CMFCstudy5Dlg::identifyNum()
{
	
//	Ptr<SVM> svm = SVM::load("mnist.xml");
	vector<vector<Point>> contours;//存放所有的轮廓，和每个轮廓的所有点
	vector<Vec4i> hierarchy;//点的指针容器

	//normalize(src, src);
							//在img1中找到轮廓并将相应信息存放到contours和hierarchy中
	findContours(src, contours, hierarchy, CV_RETR_EXTERNAL, CV_CHAIN_APPROX_NONE);


	float x_left = 0;
	vector<float> xpaixu;
	//现在得到的v队列 对应于 每个轮廓最左边的点的横坐标
	for (vector<vector<Point>>::iterator It1 = contours.begin(); It1 != contours.end(); It1++)
	{
		vector<Point> vp = *It1;
		for (vector<Point>::iterator It2 = vp.begin(); It2 != vp.end(); It2++)
		{
			Point a = *It2;
			if (It2 == vp.begin())
			{
				x_left = a.x;
				xpaixu.push_back(x_left);
			}
			else
			{
				if (a.x < x_left)
				{
					x_left = a.x;
				}
				xpaixu.pop_back();
				xpaixu.push_back(x_left);
			}
		}
	}
	vector<vector<Point>> contourstemp;
	float t = 100000;
	int p = 0;
	for (int k = 0; k < xpaixu.size(); k++)//求K次最小值
	{
		t = 1000000;
		for (int j = 0; j < xpaixu.size(); j++)//遍历一次找最小值
		{
			if (xpaixu[j] < t && xpaixu[j] != -1)
			{
				t = xpaixu[j];
				p = j;//p记录最小位置
			}
		}
		xpaixu[p] = -1;//把最小的变成-1
		contourstemp.push_back(contours[p]);
	}
	contours.assign(contourstemp.begin(), contourstemp.end());



	vector<vector<Point>>::iterator It;//遍历轮廓的迭代器

									   //提取数字	
	for (It = contours.begin(); It < contours.end(); It++) //遍历每个轮廓？？寻找轮廓是按照什么顺序？？
	{
		//画出可包围数字正外界矩形																		
		Mat ROI = src(boundingRect(*It));//roi为img1中轮廓正方形区域矩阵，boundingRect返回值为Rect
										  //	Mat _roi;
										  //	roi.copyTo(_roi);//将这个区域深拷贝出来  
		float width = boundingRect(*It).br().x - boundingRect(*It).tl().x;//宽		
		float height = boundingRect(*It).br().y - boundingRect(*It).tl().y;//高

		if ((width < height) && (height > 10)) {	//因为数字一般都是宽小于高，所以我在这里提取这些轮廓，相当于去除噪声，但不够好


			cout << height << " " << width << endl;
			//对ROI区域的图片进行大小的变换成28X28
			int des_height = height * 3 / 2;
			//int des_height=height*5/3;

			Mat desImg(des_height, des_height, CV_8U, Scalar(0, 0, 0));//28*28背景的黑图
			int begin_x = (desImg.cols - ROI.cols) / 2;//计算在desImg中添加区域的开始横坐标
													   //将图片尽量位于中间
			Mat imageROI = desImg(Rect(begin_x, height / 4, ROI.cols, ROI.rows));//建立roi区域  纵坐标设置为15 通过实践来找出来的 识别率会高一些
			ROI.copyTo(imageROI, ROI);//将原图叠加到roi区域
			resize(desImg, desImg, Size(28, 28));//改变大小

												 /*Mat element = getStructuringElement(MORPH_RECT, Size(9, 9));
												 dilate(ROI, ROI, element);*/


			Mat tempFloat;
			desImg.convertTo(tempFloat, CV_32FC1);//由于SVM需要的测试数据格式是CV_32FC1，在这里进行转换
			Mat testFeatures = Mat::zeros(1, 28 * 28, CV_32FC1);
			
			memcpy(testFeatures.data, tempFloat.data, 28 * 28 * sizeof(float));
			testFeatures = testFeatures / 255;

			int imgVectorLen = 28 * 28;//载入训练好的模型
			Mat predict_mat = Mat::zeros(1, imgVectorLen, CV_32FC1);
			memcpy(predict_mat.data, testFeatures.data, imgVectorLen * sizeof(float));
			float predict_label = svm->predict(predict_mat);		//预测
			lis.push_back(predict_label);
		}
	}
}
std::string CStringToSTDStr(const CString& theCStr)
{
	const int theCStrLen = theCStr.GetLength();
	char *buffer = (char*)malloc(sizeof(char)*(theCStrLen + 1));
	memset((void*)buffer, 0, sizeof(buffer));
	WideCharToMultiByte(CP_UTF8, 0, static_cast<CString>(theCStr).GetBuffer(), theCStrLen, buffer, sizeof(char)*(theCStrLen + 1), NULL, NULL);

	std::string STDStr(buffer);
	free((void*)buffer);
	return STDStr;
}

void CMFCstudy5Dlg::OnBnClickedIdentify()
{
	// TODO: 在此添加控件通知处理程序代码
	preDealImg();//图片预处理
	IplImage img = src;
	DrawPicToHDC(&img, IDC_SHOWIMG);//转换后直接调用就OK了！
	//normalize(src, src);
	//normalize(src, src, 1.0, 0.0, NORM_MINMAX);
	identifyNum();//对图像进行识别
	string s;
	while (!lis.empty())
	{
		float f = lis.front();
		lis.pop_front();
		string temp;
		stringstream ss;
		ss << f;
		ss >> temp;
		s.append(temp);//追加字符串
	}
	CString cstr(s.c_str());
	UpdateData(TRUE);
	Cstr_result = cstr;
	UpdateData(FALSE);
}
