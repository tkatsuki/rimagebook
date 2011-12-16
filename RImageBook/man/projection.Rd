\name{projection}

\alias{imgRowMaxs}
\alias{imgRowMins}
\alias{imgSD}
\alias{medianPrj}

\concept{Projection}

\title{Projection of 3D data}

\description{
  These functions project 3D arrays in the z direction.
}

\usage{
imgRowMaxs(x)
imgRowMins(x)
imgSD(x)
medianPrj(x)
}

\arguments{
  \item{x}{A grayscale \code{Image} class object or an array.}
}

\value{
  These functions return a matrix.
}

\details{
  \code{imgRowMaxs} projects by calculating maximum intensity of each pixel.
  \code{imgRowMins} projects by calculating minimum intensity of each pixel.
  \code{imgSD} projects by calculating standard deviation of each pixel.
  \code{medianPrj} projects by calculating median intensity of each pixel.
}

\examples{
  demo(ProjectionDemo)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}
