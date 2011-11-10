skeletonize <- function(x){
  s <- matrix(1, nrow(x), ncol(x))
  skel <- matrix(0, nrow(x), ncol(x))
  kern <- makeBrush(3, shape="diamond")
  while(max(s)==1){
    k <- opening(x, kern)
    s <- x-k
    skel <- skel | s
    x <- erode(x, kern)
  }
  return(skel)
}