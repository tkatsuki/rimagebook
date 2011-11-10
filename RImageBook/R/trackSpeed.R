trackSpeed <- function(dist, bin=5, interval=1){
  v <- c()
  for (i in 1:(length(dist)-bin)){
    v[i] <- sum(dist[i:(i+bin-1)])/bin
  }
  return(v/interval)
}