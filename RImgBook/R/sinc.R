sinc <- function(x) {
 x <- pi * x
 ifelse(x==0,1,sin(x)/(x))
}