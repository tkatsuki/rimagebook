## Demo for p.139
if(!require(rgl)){
  install.packages("rgl")
  library("rgl")
}
if(!require(misc3d)){
  install.packages("misc3d")
  library("misc3d")
}
if(!require(AnalyzeFMRI)){
  install.packages("AnalyzeFMRI")
  library("AnalyzeFMRI")
}
brain <- f.read.analyze.volume(system.file("example.img", package="AnalyzeFMRI"))
brain <- brain[,,,1]
open3d()
contour3d(brain, 1:64, 1:64, 1.5*(1:21), lev=c(3000, 8000, 10000), 
          alpha = c(0.2, 0.5, 1), 
          color = c("white", "red", "green"), echo = FALSE)
par3d(windowRect= c(0, 32, 512, 544), 
      userMatrix = rotationMatrix(5*pi/180, 0,1,0) %*% par3d("userMatrix"))
lv <- rgl.cur()
open3d()
contour3d(brain, 1:64, 1:64, 1.5*(1:21), lev=c(3000, 8000, 10000), 
          alpha = c(0.2, 0.5, 1), 
          color = c("white", "red", "green"),echo = FALSE)
par3d(windowRect = c(512, 32, 1024, 544))
rv <- rgl.cur()
source(system.file("demo", "mouseCallbacks.R", package="rgl"))
mouseTrackball(dev=c(lv, rv))
mouseZoom(2,dev=c(lv, rv))
mouseFOV(3,dev=c(lv, rv))
