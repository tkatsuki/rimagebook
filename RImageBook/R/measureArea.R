measureArea <- function(img, n=512) {
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
  intensity <- sum(imgcr)*255
  area <- length(which(mask==1))
  result <- list(intensity=intensity, size=area, average=intensity/area)
  result
}