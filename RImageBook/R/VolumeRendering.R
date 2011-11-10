VolumeRendering <- function(Data,Points,ARGB,GradientOpacityThreshold=0,
                            Spacing=c(1,1,1),RendererType=0,SamplingDistance=1.0,
                            ImageSamplingDistance=1.0,Ambient=0.4,Diffuse=0.6,
                            Specular=0.2,ParallelProjection=0) {
  .C("VolumeRendering",
     arg1=as.integer(Data),
     arg2=dim(Data),
     arg3=as.integer(Points),
     arg4=as.double(ARGB),
     arg5=length(Points),
     arg6=as.integer(GradientOpacityThreshold),
     arg7=as.double(Spacing),
     arg8=as.integer(RendererType),
     arg9=as.double(SamplingDistance),
     arg10=as.double(ImageSamplingDistance),
     arg11=as.double(Ambient),
     arg12=as.double(Diffuse),
     arg13=as.double(Specular),
     arg14=as.integer(ParallelProjection))
  NULL
}