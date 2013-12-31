\name{RImageBook}
\alias{RImageBook}
\docType{package}
\title{Package overview}
\description{
  \code{RImageBook} is an image processing utility package for R provided as a 
  supplemental material for "Digital Image Processing using R" published from 
  KYORITSU SHUPPAN CO., LTD., Japan. The primary purpose of this package is to
  demonstrate various uses of image processing and analysis functions available 
  on R.
  
  \code{RImageBook} relies on \code{EBImage} and \code{biOps} packages.
}
\details{
\tabular{ll}{
Package: \tab RImageBook\cr
Type: \tab Package\cr
Version: \tab 0.7.8\cr
Date: \tab 2013-12-31\cr
License: \tab New BSD\cr
LazyLoad: \tab yes\cr
}
}
\section{Package content}{
  Image methods
  \itemize{
    \item \code{biOps2EBI}, \code{b2E}, \code{EBI2biOps}, \code{E2b}
    \item \code{imgconv}
  }
  Geometric transformation
  \itemize{
  \item \code{skew}
  \item \code{cropImage}, \code{cropROI}
  \item \code{padding}
  \item \code{pyramid}
  
  }
  Spatial filters
  \itemize{
  \item \code{AnisotropicFilter}
  \item \code{GaussianKernel}
  \item \code{SpatialFilter2}
  \item \code{medianfilter}
  \item \code{findPeaks}
  }
  Color and contrast adjustment
  \itemize{
  \item \code{rgb2Gray}
  \item \code{pseudoColor}, \code{pseudoColor2}
  \item \code{histogram}
  \item \code{whiteBalance}
  \item \code{subtractBg}
  \item \code{adjustContrast}
  \item \code{profileLine}
  }
  Image arithmetic
  \itemize{
  \item \code{emboss}
  }
  Drawing
  \itemize{
  \item \code{rainbowBar}
  \item \code{scaleBar}
  }
  Feature extraction
  \itemize{
  \item \code{skeletonize}
  \item \code{thinning}, \code{ending}, \code{branch}, \code{isolated}, \code{pruning}
  }
  3D images and movies
  \itemize{
  \item \code{VolumeRendering}
  \item \code{GoodFeaturesToTrack}, \code{OpticalFlow}
  \item \code{tracking}, \code{trackDistance}, \code{trackSpeed}, \code{angularVelocity}, \code{msd}
  \item \code{imgRowMaxs}, \code{imgRowMins}, \code{imgSD}, \code{medianPrj}
  }
  Image recognition
  \itemize{
  \item \code{faceDetection}
  \item \code{FNCC}, \code{NCC}, \code{SAD}
  }
}
\author{
Yuichiro Hourai \email{yhourai@gmail.com}

Takeo Katsuki \email{takeo.katsuki@gmail.com}
}
\references{
https://code.google.com/p/rimagebook/
}
\keyword{ package }

\examples{
 example{thinning}
 example{tracking}
 example{AnisotropicFilter}
}
