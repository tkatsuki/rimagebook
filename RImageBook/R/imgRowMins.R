imgRowMins <- function(x) {
  args <- paste("x[,,",1:dim(x)[3],"]",sep="",collapse=",")
  command <- paste("pmin(",args,")")
  eval(parse(text=command))
}