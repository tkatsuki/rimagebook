#include <opencv2/objdetect/objdetect.hpp>
#define IN_FACEDETECTION
#include "FaceDetection.h"
#if _WIN32
#include <Windows.h>
#endif


// C++ interface
template <typename T>
int FaceDetect(const T *img, int width, int height, const char *classifier,
               int *out, int maxdetect)
{
  cv::Mat cvimg(width,height,CV_8UC1);
  double maxval = *std::max_element(img,img+width*height);
  double scale = (maxval==0)?1:255/maxval;
  /* 8bitデータへの変換 */
  for(int i=0;i<height;++i){
    for(int j=0;j<width;++j){
      *cvimg.ptr(i,j) = static_cast<unsigned char>(img[i*width+j] * scale);
    }}

  std::vector<cv::Rect> faces;
  // 顔検出器のロード
  {
  cv::CascadeClassifier cascade;
  if(cascade.load( classifier )){ 
    // 顔検出の実行
    cascade.detectMultiScale( cvimg, faces, 1.1, 2,
      CV_HAAR_SCALE_IMAGE, cv::Size(30, 30) );
  }
  }
  int n = std::min<int>(maxdetect,faces.size());
  /* 顔位置データの引渡し (配列への変換) */
  for(int i=0;i<n;++i){
    out[4*i+0] = faces[i].x;
    out[4*i+1] = faces[i].y;
    out[4*i+2] = faces[i].width;
    out[4*i+3] = faces[i].height;
  }
  return n;
}

int FaceDetectWrapperI32(const int *img, int width, int height, const char
     *classifier, int *faces, int maxdetect){
  return FaceDetect(img,width,height,classifier,faces,maxdetect);
}
int FaceDetectWrapperF64(const double *img, int width, int height, const char
     *classifier, int *faces, int maxdetect){
  return FaceDetect(img,width,height,classifier,faces,maxdetect);
}
