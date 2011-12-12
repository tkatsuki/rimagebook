\name{cropImage}

\alias{cropImage}
\alias{cropROI}

\concept{image cropping}

\title{Cropping image}

\description{
  These functions interactively crop a part of an image displayed in the plot area 
  using the mouse pointer.
  \code{cropImage} crops a rectangular area specified by a set of opposite vertices.
  \code{cropROI} crops a polygonal area specified by any desired number of vertices.
}

\usage{
cropImage(img)
cropROI(img)
}

\arguments{
  \item{img}{An image of \code{imagedata} class.} 
}

\value{
  Returns a cropped image in \code{imagedata} class.
}

\examples{
  violet <- readTiff(system.file("samples/violet.tif", package="biOps"))
  violetroi <- cropROI(violet)
  violetcr <- cropImage(violet)
  plot(violetroi)
  plot(violetcr)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

