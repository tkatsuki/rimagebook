trackDistance2 <- function (xy, unit = 1) {
  sqrt((head(xy[,1], -1) - xy[-1, 1])^2 + (head(xy[,2], -1) - xy[-1, 2])^2)*unit
}