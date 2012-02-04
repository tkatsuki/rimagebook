reenumerate2 <- function (x) {
  if (any(max(x) < 0)) 
    stop("'x' contains negative values and is incorrectly formed")
  dim <- dim(x)
  x <- apply(x, 3, function(im) {
    from <- unique(as.vector(im))
    to <- seq_along(from) - 1
    to[match(im, from)]
  })
  dim(x) <- dim
  x
}