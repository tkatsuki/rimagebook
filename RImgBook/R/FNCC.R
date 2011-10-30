FNCC <- function(a,b){            # 2ŽŸŒ³ƒf[ƒ^‚Ì‘ŠŒÝ‘ŠŠÖ
  w <- ncol(a) + ncol(b) - 1      # ŽüŠú«‚ð‘Å‚¿Á‚·‚½‚ß
  h <- nrow(a) + nrow(b) - 1      # —Ìˆæ‚ðŠg‘å
  amat <- matrix(0,nrow=h,ncol=w)
  bmat <- matrix(0,nrow=h,ncol=w)
  amat[1:nrow(a),1:ncol(a)] <- a
  bmat[1:nrow(b),1:ncol(b)] <- b
  fa <- .fft2d(amat)
  fb <- .fft2d(bmat,TRUE)
  abs(.fft2d(fa*fb,TRUE))/(h*w)
}
