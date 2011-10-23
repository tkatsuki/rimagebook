extern "C" {
  void RWrapperMedianFilterI32(
      int *img_dst, int *img_src,
      int *width, int *height, int *radius);
  void RWrapperMedianFilterF64(
      double *img_dst, double *img_src,
      int *width, int *height, int *radius);
  void RWrapperSpatialFilterI32(
      int *img_dst, int *img_src, double *weight,
      int *width, int *height, int *radius);
  void RWrapperSpatialFilterF64(
      double *img_dst, double *img_src, double *weight,
      int *width, int *height, int *radius);
}
