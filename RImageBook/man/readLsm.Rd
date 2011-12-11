\name{readLsm}

\alias{readLsm}

\concept{reading image files}

\title{Read Zeiss LSM file format}

\description{
  This function reads files in Zeiss LSM format used in laser scanning microscopy.
}

\usage{
readLsm(filename)
}

\arguments{
  \item{filename}{Path to a lsm file.} 
}

\value{
  Returns an array, the third dim of which indicates color channels.
}

\examples{
   img <- readLsm(system.file("images/R3EmRFP.lsm", package="RImageBook"))
   display(img)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

