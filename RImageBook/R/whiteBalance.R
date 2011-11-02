whiteBalance <- function(img){

  plot(img)
  imgbg <- img
  loc <- locator(1, type="p", pch=3) 

  r <- img[(nrow(img)-loc$y), loc$x, 1]
  g <- img[(nrow(img)-loc$y), loc$x, 2]
  b <- img[(nrow(img)-loc$y), loc$x, 3]
  min <- min(r, g, b)  
  rd <- r - min
  gd <- g - min
  bd <- b - min
  
  imgbg[,,1] <- rd
  imgbg[,,2] <- gd
  imgbg[,,3] <- bd

  imgc <- imgDiffer(img, imgbg)
  imgc
}