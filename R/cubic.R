cubic <- function(x,a=-0.5){
  x <- abs(x)
  ifelse(x<1,
         (a+2)*x*x*x-(a+3)*x*x+1,
         ifelse(x<2,
                a * x*x*x - 5 * a * x*x + 8 * a * x - 4 * a,
                0))
}