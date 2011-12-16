\name{faceDetection}

\alias{faceDetection}

\concept{Face detection}

\title{Face detection}

\description{
  This function detects faces from an image using Haar-like features.
}

\usage{
faceDetection(img, classifier, maxdetect = 10)
}

\arguments{
  \item{img}{A grayscale \code{Image} class object or matrix.}
  \item{classifier}{Maximum number of features.}
  \item{maxdetect}{Maximum number of faces to be detected.}
}

\value{
  Returns coordinates of corners of detected faces.
}

\details{
  This function uses OpenCV library.
}

\references{
  OpenCV: \url{http://opencv.willowgarage.com/wiki/}
}

\examples{
  demo(DetectFace)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}
