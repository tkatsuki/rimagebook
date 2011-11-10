OpticalFlow <- function(grayimg0, grayimg1, pos, winSize=10){
  .Call("OpticalFlow", grayimg0, grayimg1, as.real(pos), as.integer(winSize))
}
