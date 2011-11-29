## Demo for p.184 Fig.12.10

## Segmentation
img <- readLsm(system.file("images/R3EmRFP.lsm", package="RImageBook"))
display(img, "Original data")
ch3b <- E2b(img[,,3])
ch3bm <- imgBlockMedianFilter(ch3b, 5)
ch3m <- b2E(ch3bm)
display(ch3m, "Denoised image")
ch3th <- thresh(ch3m, 50, 50, 0.06)
display(ch3th, "Binary image")
ch3bw <- bwlabel(ch3th)
mm <- cmoments(ch3bw, ch3bw)
ch3bw <- rmObjects(ch3bw, which(mm[,'m.pxs']!=max(mm[,'m.pxs'])))
ch3bw <- ch3bw > 0

## Thinning
ske <- thinning(ch3bw)
display(normalize(ske + ch3bw), "Skeleton")
ends <- ending(ske)
branches <- branch(ske)
length(which(ends==1))
length(which(branches==1))

## Find the start point
distimg <- distmap(ch3bw)
peakpos <- which(distimg == max(distimg), arr.ind=TRUE)
peakpos
x <- ske
px <- which(x==1, arr.ind=TRUE)
pxnm <- which(x==1)
pxpeak <- rbind(px, peakpos)
peakmat <- as.matrix(dist(pxpeak))
peakcoord <- which(peakmat[nrow(pxpeak),(1:(nrow(pxpeak)-1))] == 
                   sort(peakmat[nrow(pxpeak),(1:(nrow(pxpeak)-1))])[1])
peakcoord

## Search the longest path
if(!require(igraph)){
  install.packages("igraph")
  library("igraph")
}
pxdist <- as.matrix(dist(px[,]))
pxdist[which(pxdist[,] >= 2)] <- 0
pxdist[which(pxdist[,] == 1)] <- 0.5
g <- graph.adjacency(pxdist, weight=TRUE)
endcoord <- which(ends == 1)
endpx <- which(pxnm %in% endcoord)
paths <- get.shortest.paths(g, peakcoord-1, endpx-1) 
maxpath <- paths[[which.max(sapply(paths, length))]]
maxpath <- unlist(maxpath)
pathcoord <- px[c(maxpath+1),] 
num <- pathcoord[,1] + (pathcoord[,2]-1)*nrow(x) 
x[num] <- 3
display(normalize(x), "Primary neurite")

## Get intensity profiles along the path
display(img[,,1], "Localized molecule")
ch1b <- E2b(img[,,1])
ch1bm <- imgBlockMedianFilter(ch1b, 5)
ch1m <- b2E(ch1bm)
display(ch1m, "Denoised image")
plot(ch1m[num]/ch3m[num], ylab="Relative Intensity", type="l")
