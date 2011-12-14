\name{scaleBar}

\alias{scaleBar}

\concept{Scale bar}

\title{Add a scale bar}

\description{
  This function adds a scale bar to the bottom right of an image.
}

\usage{
rainbowBar(img, col = "white", px = 60)
}

\arguments{
  \item{img}{An \code{Image} class object or a matrix.}
  \item{col}{Color of the bar.}
  \item{px}{Length of the bar.}
}

\value{
  Returns an \code{Image} class object or a matrix.
}

\examples{
  nuclei <- readImage(system.file("images/nuclei.tif", package="EBImage"))
  nucleiscale <- scaleBar(nuclei[,,1])
  display(nucleiscale)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

