#include "opencv2/video/tracking.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#define IN_OPTICALFLOW
#include "OpticalFlow.h"

template<typename T>
int GoodFeaturesToTrack(const T *img, int width, int height, int maxpos,
 double *pos, double quality, double mindist, bool bHarris, bool bSubPix){
  cv::Mat cvimg(width,height,CV_8UC1);
  double maxval = *std::max_element(img,img+width*height);
  double scale = (maxval==0)?1:255/maxval;
  /* 8bitÉfÅ[É^Ç÷ÇÃïœä∑ */
  for(int i=0;i<height;++i){
    for(int j=0;j<width;++j){
      *cvimg.ptr(i,j) = static_cast<unsigned char>(img[i*width+j] * scale);
    }}
  std::vector<cv::Point2f> cvpnts;

  cv::goodFeaturesToTrack(cvimg,cvpnts,maxpos,quality,mindist,cv::Mat(),3,bHarris);
  if(bSubPix){
    cv::TermCriteria criteria(CV_TERMCRIT_EPS | CV_TERMCRIT_ITER, 20, 0.03);
    cv::cornerSubPix(cvimg,cvpnts,cv::Size(10,10), cv::Size(-1,-1), criteria);
  }
  for(int i=0;i<cvpnts.size();++i){
    pos[2*i  ] = cvpnts[i].x;
    pos[2*i+1] = cvpnts[i].y;
  }
  return cvpnts.size();
}

int GoodFeaturesToTrackI32(const int *img, int width, int height, int maxpos,
         double *pos, double quality, double mindist, int bHarris, int bSubPix){
  return GoodFeaturesToTrack(img,width,height,maxpos,
                             pos,quality,mindist,bHarris,bSubPix);
}
int GoodFeaturesToTrackF64(const double *img, int width, int height, int maxpos,
          double *pos, double quality, double mindist, int bHarris, int bSubPix){
  return GoodFeaturesToTrack(img,width,height,maxpos,
                             pos,quality,mindist,bHarris,bSubPix);
}
