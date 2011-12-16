\name{OpticalFlow}

\alias{GoodFeaturesToTrack}
\alias{OpticalFlow}

\concept{Optical flow}

\title{Optical flow and finding good features}

\description{
  \code{GoodFeaturesToTrack} function finds useful features for optical flow detection.
  \code{OpticalFlow} function calculates the optical flow for two images 
  using the iterative Lucas-Kanade method with pyramids.
}

\usage{
GoodFeaturesToTrack(img, maxnum, quality = 0.01, mindist = 10, useHarris = 0, subPix = 0) 
OpticalFlow(grayimg0, grayimg1, pos, winSize = 10) 
}

\arguments{
  \item{img}{A grayscale \code{Image} class object.}
  \item{maxnum}{Maximum number of features.}
  \item{quality}{Bin size or window size.}
  \item{mindist}{Minimum distance between features.}
  \item{useHarris}{If not 0, Harris's corner detection algorithm will be used.}
  \item{subPix}{If not 0, the function iterates to find the sub-pixel accurate location of corners.}
  \item{grayimg0}{A grayscale image of \code{Image} class or matrix.}
  \item{grayimg1}{A grayscale image of \code{Image} class or matrix.}
  \item{pos}{Positions to calculate optical flow (e.g. the output of \code{GoodFeaturesToTrack}).}
  \item{winSize}{Size of the search window of each pyramid level.}
}

\value{
  \code{GoodFeaturesToTrack} returns a matrix of coordinates.
  \code{OpticalFlow} returns a matrix of flow vectors.
}

\details{
  These functions use OpenCV library.
}

\references{
  OpenCV: \url{http://opencv.willowgarage.com/wiki/}
}

\examples{
  demo(OpticalFlowDemo)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}
