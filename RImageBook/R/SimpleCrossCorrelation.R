NCC <- function(a,b){
 w <- ncol(a) + 2 * ncol(b) - 1
 h <- nrow(a) + 2 * nrow(b) - 1
 ma <- matrix(0,h,w)
 # 周辺を0-パディング
 ma[nrow(b):(nrow(b)+nrow(a)-1),ncol(b):(ncol(b)+ncol(a)-1)] <- a 
 mb <- .norm(b) # テンプレート画像の正規化
 cor <- matrix(0,h,w)
 for (i in 1:(w-ncol(b))) for (j in 1:(h-nrow(b))){
  sub <- ma[j:(j+nrow(b)-1),i:(i+ncol(b)-1)] # 部分画像
  cor[j, i] <- as.vector(.norm(sub)) %*% as.vector(mb)
 }
 cor
}
