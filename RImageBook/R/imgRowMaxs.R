imgRowMaxs <- function(x) {
  args <- paste("x[,,",1:dim(x)[3],"]",sep="",collapse=",")
  command <- paste("pmax(",args,")")
  eval(parse(text=command))
} 