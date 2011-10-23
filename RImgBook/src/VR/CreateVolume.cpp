#include "RVolumeRendering.h"

vtkSmartPointer<vtkImageData> CreateVolume(
  const int *Volume,
  const int Dims[3],
  const double Spacing[3]
)
{
  vtkSmartPointer<vtkImageData> VolumeImageData = vtkSmartPointer<vtkImageData>::New();
  VolumeImageData->SetDimensions(Dims);
  VolumeImageData->SetSpacing(const_cast<double*>(Spacing));
  VolumeImageData->SetScalarTypeToInt(); // ボクセルのデータ型をint型に設定
  VolumeImageData->AllocateScalars();
  int *VolumeScalarPointer = reinterpret_cast<int*>(VolumeImageData->GetScalarPointer());
  memcpy(VolumeScalarPointer,Volume,sizeof(int)*VolumeImageData->GetNumberOfPoints());

  return VolumeImageData;
}
