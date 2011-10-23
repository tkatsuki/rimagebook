angularVelocity <- function(xy, bin=5, interval=1){
  xydif <- xy[-1:-bin,] - xy[1:(nrow(xy)-bin),]
  dir <- atan(xydif[,1]/xydif[,2]) * 360/(2*pi)
  ydifneg <- which(xydif[,2]<0)
  id1 <- ydifneg[which(dir[ydifneg] <= 0)]
  id2 <- ydifneg[which(dir[ydifneg] > 0)]
  dir[id1] <- dir[id1] + 180
  dir[id2] <- dir[id2] - 180
  dirdif <- dir[-1:-bin] - dir[1:(length(dir)-bin)]
  id3 <- which(dirdif > 180)
  dirdif[id3] <- 360 - dirdif[id3]
  id4 <- which(dirdif < -180)
  dirdif[id4] <- -360 - dirdif[id4]
  angsp <- dirdif/interval
  angsp
}
