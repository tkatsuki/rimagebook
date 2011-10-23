padding <- function(img, w, h=w) {
  col <- ncol(img)
  row <- nrow(img)
  img <- rbind(matrix(0, w, col+2*h), 
               cbind(matrix(0, row, h), img, matrix(0, row, h)), 
               matrix(0, w, col+2*h))
  img
}