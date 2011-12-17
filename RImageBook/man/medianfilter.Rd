\name{medianfilter}

\alias{medianfilter}

\concept{Median spatial filter}

\title{Median filter}

\description{
  This function applies a median filter to a grayscale image.
}

\usage{
medianfilter(img, r = 1) 
}

\arguments{
  \item{img}{Grayscale image of \code{Image} class or a matrix.} 
  \item{r}{Size of the filter. \code{r} = 1 means 3 x 3 median filter.}
}

\value{
  Returns a matrix.
}

\examples{
 lena <- readImage(system.file("images/lena.bmp", package="RImageBook"))
 lenamf <- medianfilter(lena, r = 1)
 display(lena)
 display(lenamf)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

