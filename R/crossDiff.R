.crossDiff <- function(a, b){
  amat <- matrix(a, length(a), length(b))
  bmat <- matrix(b, length(a), length(b), byrow=TRUE)
  bmat-amat
}