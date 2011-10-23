imgSD <- function(x){
  nf <- getNumberOfFrames(x)
  img.ave <- rowMeans(x, dim=2)
  img.ave <- array(rep(img.ave, nf), dim=c(nrow(x), ncol(x), nf))
  img.SD <- sqrt(rowSums((x-img.ave)^2, dim=2)/(nf-1))
  img.SD
}