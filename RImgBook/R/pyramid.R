pyramid <- function(x, n=2, z=0.5){
  if (n == 0) return(x)
  xb <- EBI2biOps(x)
  res <- list(x)
  for (i in 1:n){
    tmp <- imgAverageShrink(xb, z, z)
    res[[i+1]] <- biOps2EBI(tmp)
    xb <- tmp
  }
  res
}