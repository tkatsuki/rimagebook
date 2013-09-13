tracking2 <- function (mask, maxdist = 20, bin = 3, interval = 0.1, unit = 1, size = NULL) {
  nf <- dim(mask)[3]
  ftrs <- list()
  for(i in 1:nf){
    areas <- computeFeatures.shape(mask[,,i])[, 's.area']
    moment <- computeFeatures.moment(mask[,,i])
    ftrs[[i]] <- data.frame(areas = areas, m.cx = moment[,'m.cx'], m.cy = moment[,'m.cy'])
  }
  
  ftrs[[1]] <- cbind(ftrs[[1]], Index = 1:nrow(ftrs[[1]]), Frame = 1)
  maxid <- 1
  
  if (is.null(size) == T) {
    for (i in 1:(nf - 1)) {
      distance <- distmat(ftrs[[i]][, "m.cx"], ftrs[[i]][,"m.cy"], ftrs[[i + 1]][, "m.cx"], ftrs[[i + 1]][, "m.cy"])
      if(maxid < max(ftrs[[i]][, "Index"])) maxid <- max(ftrs[[i]][, "Index"])
      ftrs[[i + 1]] <- cbind(ftrs[[i + 1]], Index = (maxid + 1):(maxid + nrow(ftrs[[i + 1]])))
      nindex <- which(distance == apply(distance, 1, min) & distance < maxdist, arr.ind = TRUE)
      ftrs[[i + 1]][nindex[, "col"], "Index"] <- ftrs[[i]][nindex[,"row"], "Index"]
      ftrs[[i + 1]] <- cbind(ftrs[[i + 1]], Frame = i + 1)
    }
  } else {
    for (i in 1:(nf - 1)) {
      distance <- distmat(ftrs[[i]][, "m.cx"], ftrs[[i]][,"m.cy"], ftrs[[i + 1]][, "m.cx"], ftrs[[i + 1]][,"m.cy"])
      sizediff <- outer(ftrs[[i]][, "areas"], ftrs[[i + 1]][, "areas"], "-")
      if(maxid < max(ftrs[[i]][, "Index"])) maxid <- max(ftrs[[i]][, "Index"])
      ftrs[[i + 1]] <- cbind(ftrs[[i + 1]], Index = (maxid + 1):(maxid + nrow(ftrs[[i + 1]])))
      nindex <- which(distance == apply(distance, 1, min) & 
                        distance < maxdist & abs(sizediff) < size, arr.ind = TRUE)
      ftrs[[i + 1]][nindex[, "col"], "Index"] <- ftrs[[i]][nindex[,"row"], "Index"]
      ftrs[[i + 1]] <- cbind(ftrs[[i + 1]], Frame = i + 1)
    }
  }
  ftrsm <- do.call(rbind, ftrs)
  xy <- ftrsm[sort.list(ftrsm[, "Index"]), ]
  xy <- cbind(xy[, "Frame"], xy[, "Index"], xy[, "m.cx"], xy[,"m.cy"])
  idb <- xy[, 2]
  from <- unique(idb)
  to <- seq_along(from)
  ida <- to[match(idb, from)]
  xy[, 2] <- ida
  ids <- nf * (xy[, 2] - 1) + xy[, 1]
  xmat <- matrix(NA, nf, max(ida))
  xmat[ids] <- xy[, 3]
  ymat <- matrix(NA, nf, max(ida))
  ymat[ids] <- xy[, 4]
  xy <- cbind(rep(unique(ida), each = nf), as.vector(xmat), 
              as.vector(ymat))
  png(filename = "trackResult.png", width = dim(mask)[1], height = dim(mask)[2], 
      bg = "black")
  par(plt = c(0, 1, 0, 1), xaxs = "i", yaxs = "i")
  matplot(xmat, ymat, type = "l", lty = 1, col = rainbow(16), 
          axes = F, xlim = c(0, dim(mask)[1]), ylim = c(0, dim(mask)[2]))
  dev.off()
  resultplot <- readImage("trackResult.png")
  resultplot <- flip(resultplot)
  unlink("trackResult.png")
  objid <- unique(xy[, 1])
  dist <- sapply(objid, function(x) c(trackDistance(xy[which(xy[, 1] == x), c(2, 3)]), NA))
  dispx <- sapply(objid, function(x) c(diff(xy[which(xy[, 1] == x), ][, 2], lag = bin), rep(NA, bin)))
  dispy <- sapply(objid, function(x) c(diff(xy[which(xy[, 1] == x), ][, 3], lag = bin), rep(NA, bin)))
  vx <- dispx/interval
  vy <- dispy/interval
  temp <- cbind(xy, as.vector(dist * unit), as.vector(dispx * unit), as.vector(dispy * unit), as.vector(dist * unit)/interval,as.vector(vx * unit), as.vector(vy * unit))
  ax <- sapply(objid, function(x) c(diff(temp[which(temp[,1] == x), ][, 8], lag = bin), rep(NA, bin)))
  ay <- sapply(objid, function(x) c(diff(temp[which(temp[,1] == x), ][, 9], lag = bin), rep(NA, bin)))
  as <- sapply(objid, function(x) c(angularVelocity(xy[which(xy[, 1] == x), c(2, 3)], bin = bin, int = interval), rep(NA, 2 * bin)))
  res <- cbind(temp, as.vector(ax/interval), as.vector(ay/interval), as.vector(as))
  res <- data.frame(obj = res[, 1], x = res[, 2], y = res[,3], distance = res[, 4], d.x = res[, 5], d.y = res[, 6], acc.x = res[, 10], acc.y = res[, 11], v.ang = res[, 12])
  result <- list(resultplot, res)
  result
}