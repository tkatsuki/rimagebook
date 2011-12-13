\name{pseudoColor}

\alias{pseudoColor}
\alias{pseudoColor2}

\concept{Pseudocolor conversion}

\title{Grayscale to pseudocolor conversion}

\description{
  These functions convert a grayscale image to a rainbow color image.
  \code{pseudoColor} converts the entire grayscale to pseudocolor, while
  \code{pseudoColor2} converts only specified portion of grayscale.
}

\usage{
pseudoColor(x)
pseudoColor2(x, min = 0, max = 255)
}

\arguments{
  \item{x}{An image of \code{Image} class.}
  \item{min, max}{Defines the range of conversion.}
}

\value{
  Returns an \code{Image} class object.
}

\examples{
  img <- readImage(system.file("images/nuclei.tif", package="EBImage"))
  psimg <- pseudoColor(img[,,1])
  psimg2 <- pseudoColor2(img[,,1], 50, 200)
  display(img[,,1])
  display(psimg)
  display(psimg2)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

