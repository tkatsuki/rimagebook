GaussianKernel <- function(x, y, s=20){
  fn <- function(x, y, s) exp(-(x^2+y^2)/(2*s^2))/(2*pi*s^2) 
  x <- seq(-floor(x/2), floor(x/2), len=x)
  y <- seq(-floor(y/2), floor(y/2), len=y)
  w <- outer(x, y, fn, s)
  w/sum(w)
}