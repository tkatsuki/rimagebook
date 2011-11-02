msd <- function(xy) {
  n <- nrow(xy)
  nd <- floor(n/4)
  msd <- matrix(0, nd)
  for (i in 1:nd){
    d <- xy[(1+i):n, 1:2] - xy[1:(n-i), 1:2]
    sd <- rowSums(d^2) 
    msd[i] <- mean(sd)
  }
  msd
}