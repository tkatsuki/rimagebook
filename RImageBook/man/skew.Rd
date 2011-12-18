\name{skew}

\alias{skew}

\concept{transformation}

\title{Skew transformation}

\description{
  Skew images. 
}

\usage{
 skew(x, theta_x = 0, theta_y = 0)
}

\arguments{
  \item{x}{An \code{Image} object or a matrix.}

  \item{theta_x}{Angle between the image and the x-axis. }

  \item{theta_y}{Angle between the image and the y-axis. }
}

\value{
  An \code{Image} object or an array, containing the transformed version
  of \code{x}.
}

\examples{
  monalisa <- readImage(system.file("images/MonaLisa.jpg", package="RImageBook"))
  display(skew(monalisa, 0, -10))
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}