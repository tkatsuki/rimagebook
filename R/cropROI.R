cropROI <- function(img, n=512) {
  img <- imgRGB2Grey(img)
  w <- ncol(img)
  h <- nrow(img)
  plot(img)
  xy <- locator(n, type="o")
  polygon(xy)
  xy <- lapply(xy, round)
  png(filename = "../../temp.png", width = w, height = h, bg = "black")
  par(plt=c(0, 1, 0, 1), xaxs="i", yaxs="i")
  plot(xy[[1]], xy[[2]], type="l", col="white", axes=F, xlim=c(0, w), ylim=c(0, h))
  polygon(xy[[1]], xy[[2]], col="white",)
  dev.off()
  mask  <-  readImage("../../temp.png")
  imge <- biOps2EBI(img)
  imgcr <- imge * mask
  maxx <- max(which(mask==1, arr.ind=TRUE)[,1])
  maxy <- max(which(mask==1, arr.ind=TRUE)[,2])
  minx <- min(which(mask==1, arr.ind=TRUE)[,1])
  miny <- min(which(mask==1, arr.ind=TRUE)[,2])
  imgcr <- imgcr[minx:maxx, miny:maxy]
  imgcr <- EBI2biOps(imgcr)
  imgcr
}