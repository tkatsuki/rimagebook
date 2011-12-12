\name{AnisotropicFilter}

\alias{AnisotropicFilter}

\concept{Anisotropic filtering}

\title{Anisotropic filter}

\description{
  This function applies anisotropic filter to an image.
}

\usage{
AnisotropicFilter(Img, Iter, Coef = 0.1)
}

\arguments{
  \item{Img}{An image of \code{Image} class.} 
  \item{Iter}{Number of iterations.}
  \item{Coef}{Diffusion coefficient.}
}

\value{
  Returns an image of \code{Image} class.
}

\examples{
  cup <- readImage(system.file("images/cupgirl.png", package="RImageBook"))
  cupgn <- b2E(imgGaussianNoise(E2b(cup), 0, 120))
  cupgnaf <- AnisotropicFilter(cupgn, 10)
  display(cup)
  display(cupgn)
  display(cupgnaf)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

