\name{rainbowBar}

\alias{rainbowBar}

\concept{Rainbow Bar}

\title{Draw a rainbow bar}

\description{
  This function generates a bar of rainbow pattern, which can be used as a legend for pseudocolor images.
}

\usage{
rainbowBar(w = 256, h = 50)
}

\arguments{
  \item{w, h}{Width and height of a bar.}
}

\value{
  Returns an array.
}

\examples{
  bar <- rainbowBar()
  display(bar)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

