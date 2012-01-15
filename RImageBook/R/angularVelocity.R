angularVelocity <- function(xy, bin=5, interval=1){
  # dir is the direction of a displacement vector
  # dir is zero for x-axis plus direction
  # dir is 180 for x-axis minus direction
  # dir is between -180 to 180 degrees
  # clockwise is minus, counterclock wise is plus
  # dirdif is the difference in direction
  # dirdif is between -180 to 180 degrees
  xydif <- xy[-1:-bin,] - xy[1:(nrow(xy)-bin),]
  id0 <- which(xydif[,1]==0)
  id0y <- which(xydif[,2]==0)
  dir <- atan(xydif[,2]/xydif[,1]) * 360/(2*pi)
  dir[id0] <- 90 
  ydifneg <- which(xydif[,2] < 0)
  xdifneg <- which(xydif[,1] < 0)
  dir[id0[id0 %in% ydifneg]] <- -90
  dir[id0y[id0y %in% xdifneg]] <- 180
  id1 <- xdifneg[which(dir[xdifneg] < 0)]
  id2 <- ydifneg[which(dir[ydifneg] > 0)]
  dir[id1] <- dir[id1] + 180
  dir[id2] <- dir[id2] - 180
  dirdif <- dir[-1:-bin] - dir[1:(length(dir)-bin)]
  id3 <- which(dirdif > 180)
  dirdif[id3] <- dirdif[id3] - 360
  id4 <- which(dirdif < -180)
  dirdif[id4] <- dirdif[id4] + 360
  angsp <- dirdif/interval
  angsp
}
