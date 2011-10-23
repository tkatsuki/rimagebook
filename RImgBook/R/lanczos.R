lanczos <- function(x,a) {
 x <- pmax(-a,pmin(a,x))
 sinc(x)*sinc(x*(1.0/a))
}