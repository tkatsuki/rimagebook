## Demo for p.135 Fig.8.12
## Requires rgl, misc3d, AnalyzeFMRI packages
## install.packages("rgl"); install.packages("misc3d"); install.packages("AnalyzeFMRI")
library("rgl")
library("misc3d")
library("AnalyzeFMRI")
brain <- f.read.analyze.volume(system.file("example.img", package="AnalyzeFMRI"))
brain <- brain[,,,1]
contour3d(brain, 1:64, 1:64, 1.5*(1:21), level=c(3000, 8000, 10000),
          alpha = c(0.2, 0.5, 1), color = c("white", "red", "green"))

## Demo for p.136 Fig.8.13
m <- array(TRUE, dim(brain))
m[1:30,1:64,1:21] <- FALSE
contour3d(brain, 1:64, 1:64, 1.5*(1:21), level=c(3000, 8000, 10000),
          mask = m, alpha = c(1, 0.5, 1),
          color = c("white", "red", "green"))
m <- array(TRUE, dim(brain))
m[1:64,1:64,10:21] <- FALSE
contour3d(brain, 1:64, 1:64, 1.5*(1:21), level=c(3000, 8000, 10000),
          mask = m, alpha = c(1, 0.5, 1),
          color = c("white", "red", "green"))