\name{SpatialFilter2}

\alias{SpatialFilter2}

\concept{Spatial filter}

\title{Spatial filter}

\description{
  This function applies a spatial filter to a grayscale image. Currently only 3 x 3 filters are supported.
}

\usage{
SpatialFilter2(img, weight, r = 1) 
}

\arguments{
  \item{img}{Grayscale image of \code{Image} class or a matrix.} 
  \item{weight}{Weight matrix or kernel.}
  \item{r}{Size of weight matrix. Currently 1 is supported.}
}

\value{
  Returns a matrix.
}

\examples{
 lena <- readImage(system.file("images/lena.bmp", package="RImageBook"))
 wt <- matrix(1/9, 3, 3)
 lenasf <- SpatialFilter2(lena, wt)
 display(lena)
 display(lenasf)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

