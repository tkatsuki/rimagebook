adjustContrast <- function(img, r=5){
  if (attr(img, "type") != "grey") stop("Image must be imagedata class grayscale.")
  plot(img)
  loc<-locator(2, type="p", pch=3)
  bg <- imgCrop(img, (loc$x[1]-r), (nrow(img)-loc$y[1]-r), 2*r, 2*r)
  bg_ave <- sum(as.vector(bg))/length(as.vector(bg))
  fg <-  imgCrop(img, (loc$x[2]-r), (nrow(img)-loc$y[2]-r), 2*r, 2*r)
  fg_ave <- sum(as.vector(fg))/length(as.vector(fg))
  img2 <- imgIncreaseContrast(img, bg_ave, fg_ave)
  return(img2)
}