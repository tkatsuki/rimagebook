\name{findPeaks}

\alias{findPeaks}

\concept{Finding peaks}

\title{Finding peaks}

\description{
  This function finds peaks in grayscale images.
}

\usage{
findPeaks(img)
}

\arguments{
  \item{img}{An image of \code{Image} class or a matrix.} 
}

\value{
  Returns a matrix.
}

\examples{
  img <- readImage(system.file("images/shapes.png", package="EBImage"))
  dm <- distmap(img)
  pk <- findPeaks(dm)
  display(pk)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

