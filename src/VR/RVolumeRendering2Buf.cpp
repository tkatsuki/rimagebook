// RVolumeRendering.cpp : Rからデータを受け取り、VTKを使ってレンダリングし、バッファに出力する。

#define IN_R_VR
#include "RVolumeRendering.h"

void VolumeRendering(
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
    )
{
  try {
    // ボリュームデータの設定
    vtkSmartPointer<vtkImageData> VolumeData = CreateVolume(Data,Dims,Spacing);

    // ボリュームマッパの設定
    vtkSmartPointer<vtkVolumeMapper> VolumeMapper
      = CreateVolumeMapper(*RendererType,*SamplingDistance,*ImageSamplingDistance);
    VolumeMapper->SetInput(VolumeData);

    // 透明度・色の設定
    vtkSmartPointer<vtkColorTransferFunction> VolumeColor =
      vtkSmartPointer<vtkColorTransferFunction>::New();
    vtkSmartPointer<vtkPiecewiseFunction> VolumeOpacity =
      vtkSmartPointer<vtkPiecewiseFunction>::New();
    for(int i=0;i<*NumPoints;++i){
      VolumeOpacity->AddPoint(Points[i],ARGB[i][0]);
      VolumeColor->AddRGBPoint(Points[i],ARGB[i][1],ARGB[i][2],ARGB[i][3]);
    }

    // 輝度勾配による透明度の設定
    vtkSmartPointer<vtkPiecewiseFunction> VolumeGradientOpacity =
      vtkSmartPointer<vtkPiecewiseFunction>::New();
    VolumeGradientOpacity->AddPoint(0,   0.0);
    VolumeGradientOpacity->AddPoint(*GradientOpacityThreshold,  1.0);

    // ボリュームデータの属性設定
    vtkSmartPointer<vtkVolumeProperty> VolumeProperty =
      vtkSmartPointer<vtkVolumeProperty>::New();
    VolumeProperty->SetColor(VolumeColor);
    VolumeProperty->SetScalarOpacity(VolumeOpacity);
    VolumeProperty->SetGradientOpacity(VolumeGradientOpacity);
    VolumeProperty->SetInterpolationTypeToLinear();
    VolumeProperty->ShadeOn();
    VolumeProperty->SetAmbient(*Ambient);
    VolumeProperty->SetDiffuse(*Diffuse);
    VolumeProperty->SetSpecular(*Specular);

    // アクタとしてボリュームを作成
    vtkSmartPointer<vtkVolume> Volume =
      vtkSmartPointer<vtkVolume>::New();
    Volume->SetMapper(VolumeMapper);
    Volume->SetProperty(VolumeProperty);

    // レンダラ・ウィンドウの設定
    vtkSmartPointer<vtkRenderer> Renderer =
      vtkSmartPointer<vtkRenderer>::New();
    vtkSmartPointer<vtkRenderWindow> Window =
      vtkSmartPointer<vtkRenderWindow>::New();
    Window->AddRenderer(Renderer);

    // レンダラにボリュームの追加
    Renderer->AddViewProp(Volume);

    // カメラ位置・方向の設定
    vtkCamera *Camera = Renderer->GetActiveCamera();
    double *Center = Volume->GetCenter();
    Camera->SetFocalPoint(Center[0], Center[1], Center[2]);
    Camera->SetPosition(Center[0] + Dims[0]*Spacing[0], Center[1], Center[2]);
    Camera->SetViewUp(0, 0, -1);
    Camera->SetParallelProjection(*ParallelProjection);
    // ウィンドウサイズの設定
    Window->SetOffScreenRendering(1);
    Window->SetSize(ScreenWidth, ScreenHeight);
    vtkSmartPointer<vtkWindowToImageFilter> WtoI = vtkSmartPointer<vtkWindowToImageFilter>::New();
    WtoI->SetInput(Window);
    WtoI->Update();
    unsigned char *Image = reinterpret_cast<unsigned char*>(WtoI->GetOutput()->GetScalarPointer());
    std::copy(Image,Image+3*ScreenWidth*ScreenHeight,DstRGB);
  } catch(...) {
  }
}

