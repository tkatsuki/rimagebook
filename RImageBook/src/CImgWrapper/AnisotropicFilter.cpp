#define cimg_display 0
#include "CImg.h"
#define IN_DEF_ANISOTROPIC_FILTER
#include "CImgWrapper.h"

// 非等方拡散フィルタを用いた円滑化 (CImgサンプルプログラムを修正)
template<typename T>
void AnisotropicFilter(T *Img, const int Dims[3], int Iter, double coef) {
  using namespace cimg_library;
  CImg<float> src(Img,Dims[0],Dims[1],1,Dims[2]);

  for(int i = 0 ; i < Iter ; ++i){
    // 速度場の計算
    CImg_3x3(I,float);
    CImg<float> veloc(Dims[0],Dims[1]); // 速度場画像
    float *ptrd = veloc.data(), betamax = 0;
    cimg_forC(src,k) // 画像の全ピクセルに対してループ(CImgマクロ)
      cimg_for3x3(src,x,y,0,k,I,float) { // 8近傍に対する処理(CImgマクロ)
        const float
          ix = (Inc - Ipc)/2,
          iy = (Icn - Icp)/2,
          ng = (float)std::sqrt(1e-10f + ix*ix + iy*iy),
          ixx = Inc + Ipc - 2*Icc,
          iyy = Icn + Icp - 2*Icc,
          ixy = 0.25f*(Inn + Ipp - Ipn - Inp),
          iee = (ix*ix*iyy + iy*iy*ixx - 2*ix*iy*ixy)/(ng*ng),
          beta = iee/(0.1f + ng);
        if (beta>betamax) betamax = beta; else if (-beta>betamax) betamax = -beta;
        *(ptrd++) = beta;
      }
    veloc*=coef/betamax;
    src+=veloc; // 元画像へのフィルタ適用
  }
  CImg<T> dst(Img,Dims[0],Dims[1],1,Dims[2],true);
  T *ptrd = dst._data;
  const float *ptrs = src._data + src.size();
  cimg_for(dst,ptrd,T) *ptrd = (T)*(--ptrs); // double/integerへの書き戻し
}

void AnisotropicFilterF64(double *Img, const int Dims[3],
                          const int *Iter, const double *Coef){
  AnisotropicFilter<double>(Img,Dims,*Iter,*Coef);
}
void AnisotropicFilterI32(int *Img, const int Dims[3],
                          const int *Iter, const double *Coef){
  AnisotropicFilter<int>(Img,Dims,*Iter,*Coef);
}
