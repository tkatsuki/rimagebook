#include "ImageFilter.h"
#include <algorithm>

using namespace std;
namespace ImageFilter {
  template<typename T1, typename T2>
  void SpatialFilter(T1 *dst, T1 *src, T2 *weight,
                     int width, int height, int radius)
  {
    for(int i=0;i<height;i++){
      for(int j=0;j<width;j++){
        int sx = max(j-radius,0), ex = min(j+radius,width-1);
        int sy = max(i-radius,0), ey = min(i+radius,height-1);
        T2 v(0), s(0);
        for(int k=sy;k<=ey;k++){
          for(int l=sx;l<=ex;l++){
            T2 w = weight[(k-sy)*(2*radius+1)+(l-sx)];
            v += src[k*width+l] * w; // d‚Ý‚ÌÏ˜a
            s += w;
          }
        }
        dst[i*width+j] = static_cast<T1>(v / s);
      }
    }
  }

  // ŽÀ‘Ì‰»
  template void SpatialFilter(double*,double*,double*,int,int,int);
  template void SpatialFilter(int*,int*,double*,int,int,int);
};
