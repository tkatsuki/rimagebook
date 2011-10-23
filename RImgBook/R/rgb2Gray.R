rgb2Gray <- function(x, coefs=c(0.30, 0.59, 0.11)) {
  r <- channel(x, "red")
  g <- channel(x, "green")
  b <- channel(x, "blue")
  y <- coefs[[1]]*r + coefs[[2]]*g + coefs[[3]]*b
}