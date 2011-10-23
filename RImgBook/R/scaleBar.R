scaleBar <- function(img, col="white", px=60) {
  w <- nrow(img)
  h <- ncol(img)
  ifelse (col == "white", i <- 0, i <- 1)
  img[(w-px-10):(w-10), (h-15):(h-10)] <- 1 - i
  img
}