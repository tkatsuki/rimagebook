trackDistance <- function(xy, unit=1){
  xydist <- dist(xy)
  xydist <- as.matrix(xydist)
  xydist <- xydist[2:nrow(xydist), 1:(nrow(xydist)-1)]
  xydist <- diag(xydist)
  xydist <- xydist*unit # um/pixel
  xydist
}