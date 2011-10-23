rainbowBar <- function(w=256, h=50){
  a <- c(0:255)
  b <- matrix(a, 256, 50)
  bn <- normalize(b)
  bnp <- pseudoColor(bn)
  bnp <-resize(bnp, w, h)
  return(bnp)
}
