pseudoColor <- function(x) {
  x <- x*255+1
  lutr <- c(rep(0, 128), seq(0, 252, by=4), rep(255, 64))
  xr <- matrix(lutr[x], nrow(x), ncol(x))
  lutg <- c(seq(0, 252, by=4), rep(255, 128), seq(252, 0, by=-4))
  xg <- matrix(lutg[x], nrow(x), ncol(x))
  lutb <- c(rep(255, 64), seq(252, 0, by=-4), rep(0, 128))
  xb <- matrix(lutb[x], nrow(x), ncol(x))
  xrgb <- rgbImage(xr/255, xg/255, xb/255)
}