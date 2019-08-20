
// MFC_study5Dlg.h: 头文件
//

#pragma once

#include "CvvImage.h"
#include "opencv2\opencv.hpp"
#include <list>
#include <iostream>
using namespace std;
using namespace cv;

using namespace cv::ml;
// CMFCstudy5Dlg 对话框
class CMFCstudy5Dlg : public CDialogEx
{
// 构造
public:
	CMFCstudy5Dlg(CWnd* pParent = nullptr);	// 标准构造函数

// 对话框数据
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_MFC_STUDY5_DIALOG };
#endif

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 支持


// 实现
protected:
	HICON m_hIcon;

	// 生成的消息映射函数
	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	Mat src;
	list<float> lis;
	Ptr<SVM> svm ;

	afx_msg void OnBnClickedOpen();
	void DrawPicToHDC(IplImage *img, UINT ID);
	void preDealImg();//对图片进行预处理
	void identifyNum();//识别图像
	afx_msg void OnBnClickedIdentify();
	CString Cstr_result;
};
