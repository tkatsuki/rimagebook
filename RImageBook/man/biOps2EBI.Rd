\name{biOps2EBI}

\alias{biOps2EBI}
\alias{b2E}
\alias{EBI2biOps}
\alias{E2b}

\concept{class conversion}

\title{Conversion between imagedata and Image class}

\description{
  These functions convert an imagedata object to an Image class object and vice versa.
}

\usage{
biOps2EBI(img)
b2E(img)
EBI2biOps(img)
E2b(img)
}

\arguments{
  \item{img}{An imagedata or Image class object.} 
}

\value{
  Returns an imagedata or Image class object.
}

\details{
  \code{biOps2EBI} and \code{b2E} convert biOps imagedata class object to EBImage Image class object.
  \code{EBI2biOps} and \code{E2b} convert Image class object to imagedata class object.
  
}

\examples{
   lena <- readImage(system.file("images/lena.tif", package="RImageBook"))
   display(lena)
   lenab <- E2b(lena)
   plot(lenab)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

