\name{padding}

\alias{padding}

\concept{padding an image}

\title{Padding an image}

\description{
  This function pads an image with specified width and height.
}

\usage{
padding(img, w, h = w)
}

\arguments{
  \item{img}{An image of \code{Image} class.} 
  \item{w, h}{Width and height of padding spaces.}
}

\value{
  Returns a padded image in \code{Image} class.
}

\examples{
  motor <- readImage(system.file("images/motorcycle.jpg", package="RImageBook"))
  motorpad <- padding(motor, 20, 10)
  display(motorpad)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

