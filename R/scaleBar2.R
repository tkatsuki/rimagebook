scaleBar2 <- function(img, px=60) {
  w <- nrow(img)
  h <- ncol(img)
  img <- cbind(img, matrix(1, w, 55))
  img[(w-px):(w), (h+10):(h+15)] <- 0
  size <- 30
  symbol <- drawfont(family="symbol", size=size)
  arial <- drawfont(family="arial", size=size)
  scalebar <- drawtext(img, c((w-px), (h+45)), "10", col="black", font=arial)
  scalebar <- drawtext(scalebar, c((w-px+35), (h+45)), "m", col="black", font=symbol)
  scalebar <- drawtext(scalebar, c((w-px+50), (h+45)), "m", col="black", font=arial)
  scalebar
}