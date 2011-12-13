\name{rgb2Gray}

\alias{rgb2Gray}

\concept{Grayscale conversion}

\title{RGB to Grayscale conversion}

\description{
  This function converts an \code{Image} class color image to grayscale at specified coefficients.
}

\usage{
rgb2Gray(x, coefs = c(0.3, 0.59, 0.11))
}

\arguments{
  \item{x}{An image of \code{Image} class.}
  \item{coefs}{Coefficients of R, G, B channel.}
}

\value{
  Returns an \code{Image} class object.
}

\examples{
  img <- readImage(system.file("images/lena.tif", package="RImageBook"))
  gimg <- rgb2Gray(img, coefs = c(0.3, 0.59, 0.11))
  display(gimg)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

