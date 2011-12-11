\name{SAD}

\alias{SAD}
\alias{NCC}
\alias{FNCC}

\concept{template matching}

\title{Template matching}

\description{
  These functions perform template matching using SAD (Sum of absolute differences), NCC (Normalized cross correlation), or FNCC (fast normalized cross correlation).
}

\usage{
SAD(trg, tmp)
NCC(trg, tmp)
FNCC(trg, tmp)
}

\arguments{
  \item{trg}{A target image of \code{Image} object or an array.} 
  \item{tmp}{A template image of \code{Image} object or an array.} 
}

\value{
  Returns a grayscale image.
}

\details{
  These functions demonstrate different algorithms for template matching.
}

\examples{
   demo(TemplateMatchingDemo)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

