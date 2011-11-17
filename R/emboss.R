emboss <- function(img, x=2, y=2){
  imgInv <- 1-img
  imgInv <- translate(imgInv, c(x, y))
  normalize(img+imgInv)
}