tracing <- function(){
# this function is for tracing skeleton from one end to others and returns vectors of coordinates.
# algorithm based on distance matrix and graph theory
  library(igraph)
  source("thinning.R")
  source("ending.R")
  source("readLsm.R")

  img <- readLsm("../image/color/R3EmRFP.lsm")
  bimg <- EBI2biOps(img[,,3])
  medimg <- imgBlockMedianFilter(bimg, 5)
  medimg <- biOps2EBI(medimg)
  bwimg <- thresh(medimg, 50, 50, 0.06)
  display(bwimg)
  #writeImage(bwimg, "../../neuronTraceThresh.eps")
  bwimg <- bwlabel(bwimg)
  mm <- cmoments(bwimg, bwimg)
  bwimg <- rmObjects(bwimg, which(mm[,'m.pxs']!=max(mm[,'m.pxs'])))
  #writeImage(bwimg, "../../neuronTraceMask.eps")
  bwimg <- bwimg > 0
  ske <- thinning(bwimg) 
  display(ske)
  display(normalize(ske + bwimg))
  #writeImage(normalize(ske + bwimg), "../doc/figures/neuronTraceSke.eps")
  skeend <- ending(ske)
  skebranch <- branch(ske)
  length(which(skeend==1))
  length(which(skebranch==1))
  
  distimg <- distmap(bwimg)
  display(normalize(distimg))
  #writeImage(normalize(distimg), "../../neuronTraceDist.eps")
  peakpos <- which(distimg == max(distimg), arr.ind=TRUE)
  peakpos
  
  x <- ske
  skepx <- which(x==1, arr.ind=TRUE)
  skepxnm <- which(x==1) # for matching end points
  skepeakpx <- rbind(skepx, peakpos) 
  skepeakmat <- as.matrix(dist(skepeakpx))
  peakcoord <- which(skepeakmat[nrow(skepeakpx),(1:(nrow(skepeakpx)-1))] == 
  sort(skepeakmat[nrow(skepeakpx),(1:(nrow(skepeakpx)-1))])[1])
  peakcoord
  
  skepxdist <- as.matrix(dist(skepx[,]))
  skepxdist[which(skepxdist[,] >= 2)] <- 0 # consider 3x3 neighbour as connected
  skepxdist[which(skepxdist[,] == 1)] <- 0.5
  g <- graph.adjacency(skepxdist, weighted=TRUE) # generate connection data

  skeendcoord <- which(skeend == 1)
  endpx <- which(skepxnm %in% skeendcoord)
  
  skepath <- get.shortest.paths(g, peakcoord-1, endpx-1)
  skemaxpath <- skepath[[which.max(sapply(skepath, length))]]
  skemaxpath <- unlist(skemaxpath)
  skepathcoord <- skepx[c(skemaxpath+1),]
  skenum <- skepathcoord[,1] + (skepathcoord[,2]-1)*nrow(x)    
  x[skenum] <- 3
  display(normalize(x))
  #writeImage(normalize(x), "../../neuronTraceResult.eps")
  
  bimg1 <- EBI2biOps(img[,,1])
  medimg1 <- imgBlockMedianFilter(bimg1, 5)
  medimg1 <- biOps2EBI(medimg1)
  plot(medimg1[skenum], type="l")

 
}