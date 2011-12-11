\name{readAVI}

\alias{readAVI}

\concept{reading image files}

\title{Read uncompressed AVI movie files}

\description{
  This function loads a movie data from an uncompressed AVI file.
}

\usage{
readAVI(filepath)
}

\arguments{
  \item{filepath}{Path to a movie file.} 
}

\value{
  Returns an 8 bit array.
}

\examples{
   para <- readAVI(system.file("images/paramecium.avi", package="RImageBook"))
   display(para/255)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

