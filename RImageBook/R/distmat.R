distmat <- function(x1, y1, x2, y2){
  x <- outer(x1, x2, function(c1, c2) (c1 - c2)^2)
  y <- outer(y1, y2, function(c1, c2) (c1 - c2)^2)
  sqrt(x + y)
}