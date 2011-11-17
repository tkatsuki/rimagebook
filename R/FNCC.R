FNCC <- function(a,b){            # 2次元データの相互相関
  w <- ncol(a) + ncol(b) - 1      # 周期性を打ち消すため
  h <- nrow(a) + nrow(b) - 1      # 領域を拡大
  amat <- matrix(0,nrow=h,ncol=w)
  bmat <- matrix(0,nrow=h,ncol=w)
  amat[1:nrow(a),1:ncol(a)] <- a
  bmat[1:nrow(b),1:ncol(b)] <- b
  fa <- .fft2d(amat)
  fb <- .fft2d(bmat,TRUE)
  abs(.fft2d(fa*fb,TRUE))/(h*w)
}
