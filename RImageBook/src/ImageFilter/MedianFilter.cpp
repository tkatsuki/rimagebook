#include "ImageFilter.h"
#include <algorithm>
#include <vector>

using namespace std;
namespace ImageFilter {
  template<typename T>
  void MedianFilter(T *dst, T *src, int width, int height, int radius)
  {
    vector<T> buf;
    for(int i=0;i<height;i++){
      for(int j=0;j<width;j++){
        int sx = max(j-radius,0), ex = min(j+radius,width-1);
        int sy = max(i-radius,0), ey = min(i+radius,height-1);
        buf.clear();
        for(int k=sy;k<=ey;k++){
          for(int l=sx;l<=ex;l++){
            buf.push_back(src[k*width+l]);
          }
        }
        int mid = buf.size()/2;
        nth_element(buf.begin(),buf.begin()+mid,buf.end());
        dst[i*width+j] = buf[mid];
      }
    }
  }

  // ŽÀ‘Ì‰»
  template void MedianFilter(double*,double*,int,int,int);
  template void MedianFilter(int*,int*,int,int,int);
};

