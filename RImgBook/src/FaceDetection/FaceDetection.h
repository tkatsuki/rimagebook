#pragma once

#ifndef IN_FACEDETECTION
#define DLL_EXPORT __declspec(dllimport)
#else
#define DLL_EXPORT __declspec(dllexport)
#endif

extern "C" {
DLL_EXPORT int FaceDetectWrapperI32(const    int *img, int width, int height, const char *classifier, int *faces, int maxdetect);
DLL_EXPORT int FaceDetectWrapperF64(const double *img, int width, int height, const char *classifier, int *faces, int maxdetect);
}

