\name{thinning}

\alias{skeletonize}
\alias{thinning}
\alias{ending}
\alias{branch}
\alias{isolated}
\alias{pruning}

\concept{thinning}

\title{Thinning and skeletonization}

\description{
  These functions are for thinning, skeletonization, and analysis of thinned binary images.
  \code{skeletonize} skeletonizes a binary image using morphological operations.
  Topology may not be preserved.
  \code{thinning} thins a binary image using a method of Gonzalez and Woods (see reference).
  Topology is preserved.
  \code{ending} detects end points from a thinned image.
  \code{branch} detects branch points from a thinned image.
  \code{isolated} detects isolated points from a thinned image.
  \code{pruning} prunes (removes branches) a thinned image.
}

\usage{
skeletonize(x)
thinning(x)
ending(x)
branch(x)
isolated(x)
pruning(x, n = 20)
}

\arguments{
  \item{img}{A binary image of \code{Image} class or matrix.} 
  \item{n}{Number of pixels to prune.}
}

\value{
  Return a matrix or an \code{Image} class object.
}

\references{
  Gonzales, Rafael C.; Woods, Richard E. (2001), Digital Image Processing
}

\examples{
  demo(ThinningDemo)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

