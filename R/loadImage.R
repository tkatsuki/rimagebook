loadImage <- function(x) {
  eval(parse(text=paste("readImage(system.file(\"images/", x, "\", package=\"RImageBook\"))", sep="")))
}