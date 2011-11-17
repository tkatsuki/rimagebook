#pragma once
#include <vtkImageData.h>
#include <vtkSmartPointer.h>
#include <vtkRenderer.h>
#include <vtkRenderWindow.h>
#include <vtkRenderWindowInteractor.h>
#include <vtkVolume.h>
#include <vtkFixedPointVolumeRayCastMapper.h>
#include <vtkGPUVolumeRayCastMapper.h>
#include <vtkVolumeProperty.h>
#include <vtkColorTransferFunction.h>
#include <vtkPiecewiseFunction.h>
#include <vtkCamera.h>
#include <vtkWindowToImageFilter.h>
#include <limits>

#if _WIN32
# ifndef IN_R_VR
#  define DLL_EXPORT __declspec(dllimport)
# else
#  define DLL_EXPORT __declspec(dllexport)
# endif
#else
# define DLL_EXPORT
#endif
extern "C" {
  DLL_EXPORT
void VolumeRendering(
    const int *Data,
    const int Dims[3],
    const int *Points,
    const double ARGB[][4],
    const int *NumPoints,
    const int *GradientOpacityThreshold,
    const double Spacing[3],
    const int *RendererType,
    const double *SamplingDistance,
    const double *ImageSamplingDistance,
    const double *Ambient,
    const double *Diffuse,
    const double *Specular,
    const int *ParallelProjection
    );

  void VolumeRendering2Buf(
    unsigned char *DstRGB,
    int ScreenWidth,
    int ScreenHeight,
    const int *Data,
    const int Dims[3],
    const int *Points,
    const double ARGB[][4],
    const int *NumPoints,
    const int *GradientOpacityThreshold,
    const double Spacing[3],
    const int *RendererType,
    const double *SamplingDistance,
    const double *ImageSamplingDistance,
    const double *Ambient,
    const double *Diffuse,
    const double *Specular,
    const int *ParallelProjection
    );
}

vtkSmartPointer<vtkImageData> CreateVolume(
  const int *Volume,
  const int Dims[3],
  const double Spacing[3]
);

vtkSmartPointer<vtkVolumeMapper> CreateVolumeMapper(
  int RendererType,
  double SamplingDistance,
  double ImageSamplingDistance
);
