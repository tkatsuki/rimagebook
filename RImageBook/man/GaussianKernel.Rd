\name{GaussianKernel}

\alias{GaussianKernel}

\concept{Gaussian Kernel}

\title{Gaussian Kernel}

\description{
  This function generates a Gaussian kernel of desired sizes, which might be useful for spatial and frequency filtering.
}

\usage{
GaussianKernel(x, y, s = 20)
}

\arguments{
  \item{x, y}{Size of the kernel in x-axis and y-axis.} 
  \item{s}{Standard deviation, sigma.}
}

\value{
  Returns a matrix.
}

\examples{
 gauss9 <- GaussianKernel(9, 9, 5)
 display(normalize(gauss9))
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

