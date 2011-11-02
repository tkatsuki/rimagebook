// ImageFilter.h

namespace ImageFilter {
  template<typename T1, typename T2>
  extern void SpatialFilter(T1 *dst, T1 *src, T2 *weight,
                       int width, int height, int radius);
  template<typename T>
  extern void MedianFilter(T *dst, T *src, int width, int height, int radius);
}
