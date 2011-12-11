\name{imgconv}

\alias{imgconv}

\concept{file format conversion}

\title{Conversion between different file formats}

\description{
  This function converts all image files in a directory from one file format 
  to other using \code{readImage} and \code{writeImage} function of EBImage.
}

\usage{
imgconv(dirname = 0, format1, format2, quality = 100)
}

\arguments{
  \item{dirname}{Path to a directory.} 
  \item{format1}{A string, giving an input file extension.} 
  \item{format2}{A string, giving an output file extension.} 
  \item{quality}{A numeric, ranging from 1 to 100. Default is 100.} 
}

\value{
  Returns \code{invisible(files)}.
}

\details{
  This is a wrapper of \code{readImage} and \code{writeImage}.
  Supported file formats are same as \code{readImage}.
  Original files are preserved after conversion.
}

\author{
  Yuichiro Hourai, \email{yhourai@gmail.com}
  
  Takeo Katsuki, \email{takeo.katsuki@gmail.com}
}

