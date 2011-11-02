#include "opencv2/video/tracking.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#define IN_OPTICALFLOW
#include "OpticalFlow.h"

template<typename T>
void OpticalFlow(const T *src0, const T *src1, int width, int height,
                 const double *points0, double *points1, int num, int r){
  cv::Mat cvimg0(width,height,CV_8UC1);
  cv::Mat cvimg1(width,height,CV_8UC1);
  double maxval = std::max(*std::max_element(src0,src0+width*height),
                           *std::max_element(src1,src1+width*height));
  double scale = (maxval==0)?1:255/maxval;
  /* 8bitÉfÅ[É^Ç÷ÇÃïœä∑ */
  for(int i=0;i<height;++i){
    for(int j=0;j<width;++j){
      *cvimg0.ptr(i,j) = static_cast<unsigned char>(src0[i*width+j] * scale);
      *cvimg1.ptr(i,j) = static_cast<unsigned char>(src1[i*width+j] * scale);
    }}
  std::vector<cv::Point2f> cvpnts0(num), cvpnts1;
  for(int i=0;i<num;++i){
    cvpnts0[i].x = points0[2*i  ];
    cvpnts0[i].y = points0[2*i+1];
  }

  std::vector<uchar> status;
  std::vector<float> err;

  cv::calcOpticalFlowPyrLK(cvimg0,cvimg1,cvpnts0,cvpnts1,
                           status,err,cv::Size(r,r));

  for(int i=0;i<num;++i){
    points1[4*i  ] = cvpnts1[i].x;
    points1[4*i+1] = cvpnts1[i].y;
    points1[4*i+2] = status[i];
    points1[4*i+3] = err[i];
  }
}

void OpticalFlowI32(const int *src0, const int *src1, int width, int height,
                    const double *points0, double *points1, int num, int r){
  OpticalFlow(src0,src1,width,height,points0,points1,num,r);
}
void OpticalFlowF64(const double *src0, const double *src1, int width, int height,
                    const double *points0, double *points1, int num, int r){
  OpticalFlow(src0,src1,width,height,points0,points1,num,r);
}
