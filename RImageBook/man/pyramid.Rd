\name{pyramid}

\alias{pyramid}

\concept{generating an image pyramid}

\title{Generating an image pyramid}

\description{
  This function generates an image pyramid of specified zoom ratio and iterations.
}

\usage{
pyramid(x, n = 2, z = 0.5)
}

\arguments{
  \item{x}{An image of \code{Image} class.} 
  \item{n}{Number of iterations.}
  \item{z}{Zoom ratio.}
}

\value{
  Returns an image pyramid of \code{Image} class.
}

\examples{
  monalisa <- readImage(system.file("images/MonaLisa.jpg", package="RImageBook"))
  pr <- pyramid(monalisa, 3)
  display(pr[[1]])
  display(pr[[2]])
  display(pr[[3]])
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

