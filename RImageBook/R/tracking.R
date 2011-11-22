tracking <- function(mask, maxdist=20, bin=3, interval=0.1, unit=1, size=NULL){
  if(!require(spatstat)){
  install.packages("spatstat")
  library("spatstat")
  }
  ftrs <- cmoments(mask, mask)
  nf <- dim(mask)[3]
  
  ftrs[[1]] <- cbind(ftrs[[1]], Index=1:nrow(ftrs[[1]]))
  if (is.null(size)==T){                 
    for (i in 1:(nf-1)){
      distmat <- crossdist(ftrs[[i]][,"m.x"], ftrs[[i]][,"m.y"], 
                                 ftrs[[i+1]][,"m.x"], ftrs[[i+1]][,"m.y"])
      sizediff <- .crossDiff(ftrs[[i]][,"m.pxs"], ftrs[[i+1]][,"m.pxs"])
      maxid <- max(ftrs[[i]][,"Index"])
      ftrs[[i+1]] <- cbind(ftrs[[i+1]], Index=(maxid+1):(maxid+nrow(ftrs[[i+1]])))
      nindex <- which(distmat == apply(distmat, 1, min) & 
        distmat < maxdist, arr.ind=TRUE)
      ftrs[[i+1]][nindex[,"col"],"Index"] <- ftrs[[i]][nindex[,"row"],"Index"]
      }
    }else {
      for (i in 1:(nf-1)){
        distmat <- crossdist(ftrs[[i]][,"m.x"], ftrs[[i]][,"m.y"], 
                                   ftrs[[i+1]][,"m.x"], ftrs[[i+1]][,"m.y"])
        sizediff <- .crossDiff(ftrs[[i]][,"m.pxs"], ftrs[[i+1]][,"m.pxs"])
        maxid <- max(ftrs[[i]][,"Index"])
        ftrs[[i+1]] <- cbind(ftrs[[i+1]], Index=(maxid+1):(maxid+nrow(ftrs[[i+1]])))
        nindex <- which(distmat == apply(distmat, 1, min) & 
          distmat < maxdist & abs(sizediff) < size, arr.ind=TRUE)
        ftrs[[i+1]][nindex[,"col"],"Index"] <- ftrs[[i]][nindex[,"row"],"Index"]
        }
      }
  detach("package:spatstat")

  xy <- c()
  for (i in unique(unlist(sapply(ftrs, function(x) x[,'Index'])))) for(j in 1:nf) {
    xy <- rbind(xy, c(i, as.numeric(sapply(ftrs[j], function(x) x[which(x[,'Index']==i),'m.x'])),
                      as.numeric(sapply(ftrs[j], function(x) x[which(x[,'Index']==i),'m.y']))))
    }

  xmat <- matrix(xy[,2], nf)
  ymat <- matrix(xy[,3], nf)

  png(filename = "trackResult.png", width = dim(mask)[1], height = dim(mask)[2], bg = "black")
  par(plt=c(0,  1,  0,  1),  xaxs="i",  yaxs="i")
  matplot(xmat, ymat, type="l", lty=1, col=rainbow(16), axes = F, xlim = c(0, dim(mask)[1]), ylim = c(0, dim(mask)[2]))
  dev.off()
  resultplot <- readImage("trackResult.png")
  resultplot <- flip(resultplot)
  unlink("trackResult.png")
  objid <- unique(as.vector(xy[,1]))

  # distance
  dist <- sapply(objid, function(x) c(trackDistance(xy[which(xy[,1]==x), c(2,3)]), NA))
  # x-coordinate of displacement
  dispx <- sapply(objid, function(x) c(diff(xy[which(xy[,1]==x),][,2], lag=bin), rep(NA, bin)))
  # y-coordinate of displacement
  dispy <- sapply(objid, function(x) c(diff(xy[which(xy[,1]==x),][,3], lag=bin), rep(NA, bin)))
  # x-coordinate of velocity vector
  vx <- dispx/interval
  # y-coordinate of velocity vector
  vy <- dispy/interval
  temp <- cbind(xy, as.vector(dist*unit), as.vector(dispx*unit), as.vector(dispy*unit), 
                as.vector(dist*unit)/interval, as.vector(vx*unit), as.vector(vy*unit))
  # x-coordinate of acceleration vector
  ax <- sapply(objid, function(x) c(diff(temp[which(temp[,1]==x),][,8], lag=bin), rep(NA, bin)))
  # y-coordinate of acceleration vector
  ay <- sapply(objid, function(x) c(diff(temp[which(temp[,1]==x),][,9], lag=bin), rep(NA, bin)))
  # angular velocity
  as <- sapply(objid, function(x) c(angularVelocity(xy[which(xy[,1]==x), c(2,3)], bin=bin, int=interval), rep(NA, 2*bin)))

  # concatenate coordinates, distance, displacement, speed, velocity, acceleration, angular velocity
  res <- cbind(temp, as.vector(ax/interval), as.vector(ay/interval), as.vector(as)) 

  res <- data.frame("obj"=res[,1], "x"=res[,2], "y"=res[,3],
                    "distance"=res[,4], "d.x"=res[,5], "d.y"=res[,6],
                    "speed"=res[,7], "v.x"=res[,8], "v.y"=res[,9],
                    "acc.x"=res[,10], "acc.y"=res[,11], "v.ang"=res[,12])
  
  result <- list(resultplot, res)
  result
}