.norm <- function(x) {
  nx <- x - sum(x)/length(x)
  nx <- nx/sqrt(sum(nx*nx))
  nx
}