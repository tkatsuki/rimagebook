#pragma once

#ifndef IN_OPTICALFLOW
#define DLL_EXPORT __declspec(dllimport)
#else
#define DLL_EXPORT __declspec(dllexport)
#endif

extern "C" {
DLL_EXPORT void OpticalFlowI32(const    int *img0, const    int *img1, int width, int height, const double *pnts0, double *pnts1, int num, int r);
DLL_EXPORT void OpticalFlowF64(const double *img0, const double *img1, int width, int height, const double *pnts0, double *pnts1, int num, int r);
DLL_EXPORT int GoodFeaturesToTrackI32(const    int *img, int width, int height, int maxpos, double *pos, double quality, double mindist, int bHarris, int bSubPix);
DLL_EXPORT int GoodFeaturesToTrackF64(const double *img, int width, int height, int maxpos, double *pos, double quality, double mindist, int bHarris, int bSubPix);
}
