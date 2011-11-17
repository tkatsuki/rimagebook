#include "../ImageFilter/ImageFilter.h"

extern "C" {
  void RWrapperMedianFilterI32(int *dst, int *src,
                               int *width, int *height, int *radius)
  {
    ImageFilter::MedianFilter(dst,src,*width,*height,*radius);
  }

  void RWrapperMedianFilterF64(double *dst, double *src,
                               int *width, int *height, int *radius)
  {
    ImageFilter::MedianFilter(dst,src,*width,*height,*radius);
  }
}
