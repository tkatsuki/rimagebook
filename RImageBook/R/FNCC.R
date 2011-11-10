FNCC <- function(a,b){
  w <- ncol(a) + ncol(b) - 1
  h <- nrow(a) + nrow(b) - 1
  amat <- matrix(0, nrow=h, ncol=w)
  bmat <- matrix(0, nrow=h, ncol=w)
  amat[1:nrow(a), 1:ncol(a)] <- a
  bmat[1:nrow(b), 1:ncol(b)] <- b
  fa <- .fft2d(amat)
  fb <- .fft2d(bmat, TRUE)
  abs(.fft2d(fa*fb, TRUE))/(h*w)
}
