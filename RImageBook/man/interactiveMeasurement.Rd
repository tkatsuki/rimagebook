\name{whiteBalance}

\alias{whiteBalance}
\alias{subtractBg}
\alias{adjustContrast}
\alias{measureArea}
\alias{profileLine}

\concept{Interactive measurement}

\title{Interactive measurement and adjustment of images}

\description{
  These functions measure and adjust image intensities using \code{locator}.
  \code{whiteBalance} adjusts color balance by selecting a gray reference.
  \code{subtractBg} subtracts background intensity by selecting a background area.
  \code{adjustContrast} adjusts contrast of a grayscale image by selecting a dark area and a bright area.
  \code{measureArea} measures the total intensity, size, and average intensity of a selected polygonal area.
  \code{profileLine} measures intensity profiles along a specified line segments.
}

\usage{
whiteBalance(img)
subtractBg(img, r = 20)
adjustContrast(img, r = 5)
measureArea(img, n = 512)
profileLine(img, n = 2)
}

\arguments{
  \item{img}{An image of \code{imagedata} class.}
  \item{r}{Radius of an area.}
  \item{n}{The maximum number of points to locate.}
}

\value{
  \code{whiteBalance}, \code{subtractBg}, \code{adjustContrast} returns an \code{imagedata} class object.
  \code{measureArea} returns a list that contains the total intensity, size, and average intensity of 
  the selected area.
  \code{profileLine} plots a line profile.
}

\examples{
  violet <- readTiff(system.file("samples/violet.tif", package="biOps"))
  violetwb <- whiteBalance(violet)
  violetsb <- subtractBg(violet)
  violetac <- adjustContrast(violet)
  res <- measureArea(violet)
  profileLine(violet)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

