tracking2 <- function (mask, maxdist = 20, bin = 3, interval = 0.1, unit = 1, size = NULL) {
  nf <- dim(mask)[3]
  ftrs <- list()
  skip <- rep(T, nf)

  for(i in 1:nf){
    areas <- computeFeatures.shape(mask[,,i])[, 's.area']
    moment <- computeFeatures.moment(mask[,,i])
    if(is.null(areas)) skip[i] <- F
    ftrs[[i]] <- data.frame(areas = areas, m.cx = moment[,'m.cx'], m.cy = moment[,'m.cy'])
  }
  objfr <- which(skip==T)
  ftrs[[1]] <- cbind(ftrs[[1]], Index = 1:nrow(ftrs[[1]]), Frame = 1)
  maxid <- 1

  if (is.null(size) == T) {
    for (i in 1:(nf - 1)) {
      distance <- distmat(ftrs[[objfr[i]]][, "m.cx"], ftrs[[objfr[i]]][,"m.cy"], 
                          ftrs[[objfr[i + 1]]][, "m.cx"], ftrs[[objfr[i + 1]]][,"m.cy"])
      if(maxid < max(ftrs[[objfr[i]]][, "Index"])) maxid <- max(ftrs[[objfr[i]]][, "Index"])
      ftrs[[objfr[i + 1]]] <- cbind(ftrs[[objfr[i + 1]]], Index = (maxid + 1):(maxid + nrow(ftrs[[objfr[i + 1]]])))
      nindex <- which(distance == apply(distance, 1, min) & distance < maxdist, arr.ind = TRUE)
      ftrs[[objfr[i + 1]]][nindex[, "col"], "Index"] <- ftrs[[objfr[i]]][nindex[,"row"], "Index"]
      ftrs[[objfr[i + 1]]] <- cbind(ftrs[[objfr[i + 1]]], Frame = i + 1)
    }
  } else {
    for (i in 1:(length(objfr)-1)) {
      distance <- distmat(ftrs[[objfr[i]]][, "m.cx"], ftrs[[objfr[i]]][,"m.cy"], 
                          ftrs[[objfr[i + 1]]][, "m.cx"], ftrs[[objfr[i + 1]]][,"m.cy"])
      sizediff <- outer(ftrs[[objfr[i]]][, "areas"], ftrs[[objfr[i + 1]]][, "areas"], "-")
      if(maxid < max(ftrs[[objfr[i]]][, "Index"])) maxid <- max(ftrs[[objfr[i]]][, "Index"])
      ftrs[[objfr[i + 1]]] <- cbind(ftrs[[objfr[i + 1]]], Index = (maxid + 1):(maxid + nrow(ftrs[[objfr[i + 1]]])))
      nindex <- which(distance == apply(distance, 1, min) & 
                        distance < maxdist & abs(sizediff) < size, arr.ind = TRUE)
      ftrs[[objfr[i + 1]]][nindex[, "col"], "Index"] <- ftrs[[objfr[i]]][nindex[,"row"], "Index"]
      ftrs[[objfr[i + 1]]] <- cbind(ftrs[[objfr[i + 1]]], Frame = i + 1)
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
  res <- data.frame(obj = res[, 1], x = res[, 2], y = res[,3], distance = res[, 4], d.x = res[, 5], d.y = res[, 6],  speed = res[, 7], v.x = res[, 8], v.y = res[, 9], acc.x = res[, 10], acc.y = res[, 11], v.ang = res[, 12])
  result <- list(resultplot, res)
  result
}