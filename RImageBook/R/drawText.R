drawText <- function(img, text, x=ncol(img)/2, y=10, ...){
  # Somehow the image gets shifted and leaves black line at the right and bottom
  require(RImageBook)
  imgb <- E2b(img)
  png(filename = "temp.png", width = dim(img)[1], height = dim(img)[2], bg = "black")
  par(mar=c(0, 0, 0, 0))
  plot(imgb)
  text(x, y=y, labels = text, pos=3, ...)
  dev.off()
  img <- readImage("temp.png")
  unlink("temp.png")
  img
}