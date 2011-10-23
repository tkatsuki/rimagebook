#pragma once

#if _WIN32
# ifndef IN_DEF_ANISOTROPIC_FILTER
#  define AF_DECLARE __declspec(dllimport)
# else
#  define AF_DECLARE __declspec(dllexport)
# endif
#else
# define AF_DECLARE
#endif
extern "C" {
AF_DECLARE void AnisotropicFilterF64(double *ImgDst, const int Dims[3], const int *Iter, const double *Coef);
AF_DECLARE void AnisotropicFilterI32(double *ImgDst, const int Dims[3], const int *Iter, const double *Coef);
}
