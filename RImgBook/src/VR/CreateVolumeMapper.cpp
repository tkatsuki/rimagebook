#include "RVolumeRendering.h"

vtkSmartPointer<vtkVolumeMapper> CreateVolumeMapper(
  int RendererType,
  double SamplingDistance,
  double ImageSamplingDistance
)
{
  switch(RendererType){
  default:
  case 0:
  {
    vtkSmartPointer<vtkFixedPointVolumeRayCastMapper> volumeMapper
      = vtkSmartPointer<vtkFixedPointVolumeRayCastMapper>::New();
    volumeMapper->SetSampleDistance(SamplingDistance);
    volumeMapper->SetImageSampleDistance(ImageSamplingDistance);
    volumeMapper->SetMinimumImageSampleDistance(ImageSamplingDistance);
    return volumeMapper;
  }
  case 1:
  {
    vtkSmartPointer<vtkGPUVolumeRayCastMapper> volumeMapper
      = vtkSmartPointer<vtkGPUVolumeRayCastMapper>::New();
    volumeMapper->SetSampleDistance(SamplingDistance);
    volumeMapper->SetImageSampleDistance(ImageSamplingDistance);
    volumeMapper->SetMinimumImageSampleDistance(ImageSamplingDistance);
    return volumeMapper;
  }
  case 2:
    vtkSmartPointer<vtkFixedPointVolumeRayCastMapper> volumeMapper
      = vtkSmartPointer<vtkFixedPointVolumeRayCastMapper>::New();
    volumeMapper->SetSampleDistance(SamplingDistance);
    volumeMapper->SetImageSampleDistance(ImageSamplingDistance);
    volumeMapper->SetMinimumImageSampleDistance(ImageSamplingDistance);
    volumeMapper->SetBlendModeToMaximumIntensity();
    return volumeMapper;
  }
}