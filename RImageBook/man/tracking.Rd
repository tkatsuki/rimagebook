\name{tracking}

\alias{tracking}
\alias{trackDistance}
\alias{trackSpeed}
\alias{angularVelocity}
\alias{msd}

\concept{tracking}

\title{Tracking and analysis of moving objects}

\description{
  These functions are for tracking and analyzing objects in movies.
  \code{tracking} calculates various values related to object motion.
  \code{trackDistance} calculates distance traveled by objects during the specified time window.
  \code{trackSpeed} calculates average speed of objects during the specified time window.
  \code{angularVelocity} calculates angular velocity of moving objects.
  \code{msd} calculates mean square diviation of object trajectories.
}

\usage{
tracking(mask, maxdist = 20, bin = 3, interval = 0.1, unit = 1, size = NULL)
trackDistance(xy, unit = 1)
trackSpeed(dist, bin = 5, interval = 1)
angularVelocity(xy, bin = 5, interval = 1)
msd(xy)
}

\arguments{
  \item{mask}{Labeled binary movie.} 
  \item{maxdist}{Maximum distance for object association.}
  \item{bin}{Window size for averaging.}
  \item{interval}{Time intervals.}
  \item{unit}{Unit length.}
  \item{size}{Maximum size difference for objects association.}
  \item{xy}{A matrix of object coordinates.}
  \item{dist}{Traveled distance (e.g. the output of \code{trackDistance}).}
}

\value{
  \code{tracking} returns a list consisting of an image object and a dataframe.
  The image object shows trajectories of all objects. The dataframe contains the following values:
  \item{obj}{Object ID.}
  \item{x, y}{Coordinate of objects.}
  \item{distance}{Traveled distance.}
  \item{d.x, d.y}{Displacement.}
  \item{speed}{Speed.}
  \item{v.x, v.y}{Velocity.}
  \imte{acc.x, acc.y}{Acceleration.}
  \item{v.ang}{Angular velocity.}
  
}

\examples{
  demo(ParameciumTrackingDemo)
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

