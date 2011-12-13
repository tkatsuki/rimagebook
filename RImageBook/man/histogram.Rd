\name{histogram}

\alias{histogram}

\concept{histogram}

\title{Histogram of pixel intensities}

\description{
  This function displays a histogram of pixel intensities from images.
  This is a wrapper function for \code{hist}.
}

\usage{
histogram(x, breaks = 512, xlim = c(0, 1), ylim = NULL, main = "", col = "black")
}

\arguments{
  \item{x}{An image of \code{Image} or \code{imagedata} class or an array.}
  \item{breaks}{A single number giving the number of cells for the histogram.}
  \item{xlim, ylim}{the range of x and y values with sensible defaults.}
  \item{col}{A colour to be used to fill the bars.}
}

\value{
  An object of class "histogram" 
}

\seealso{
  \code{hist}
}

\examples{
  img <- readImage(system.file("images/lena.tif", package="RImageBook"))
  histogram(img)
  histogram(img[,,1])
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

