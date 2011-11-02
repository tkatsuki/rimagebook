\name{VolumeRendering}
\alias{VolumeRendering}
\title{Volume Rendering}
\description{Volume rendering with VTK}
\usage{
 VolumeRendering(Data, Points, ARGB, GradientOpacityThreshold = 0, Spacing = c(1, 
    1, 1), RendererType = 0, SamplingDistance = 1, ImageSamplingDistance = 1, 
    Ambient = 0.4, Diffuse = 0.6, Specular = 0.2, ParallelProjection = 0) )
}
\arguments{
 \item{Data}{Volume data(3D array)}
 \item{Points}{Points on opacity curve (voxel values)}
 \item{ARGB}{ARGB corresponding to voxel values (length(Points) * 4 = length(ARGB))}
 \item{GradientOpacityThreshold}{Increase opacity where gradient is small.}
 \item{Spacing}{Voxel size in XYZ directions}
 \item{RendererType}{VTK volume mapper index}
 \item{SamplingDistance}{Sampling distance (in ray direction)}
 \item{ImageSamplingDistance}{Sampling distance (screen)}
 \item{Ambient}{Shading parameter - Ambient}
 \item{Diffuse}{Shading parameter - Diffuse}
 \item{Specular}{Shading parameter - Specular}
 \item{ParallelProjection}{Parallel projection/Perspective projection}
}

\examples{
}

