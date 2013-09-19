drawText <- function(img, text, x=ncol(img)/2, y=10, ...){
  require(RImageBook)
  if(length(dim(img))!=2) stop("Only 2D array is supported.")
  img <- cbind(rep(0, nrow(img)), img) 
  img <- rbind(rep(0, ncol(img)), img)
  imgb <- E2b(img)
  .pardefault <- par(no.readonly = T)
  png(filename = "temp.png", width = dim(img)[1], height = dim(img)[2], bg = "black")
  par(mar=c(0, 0, 0, 0))
  plot(imgb)
  text(x, y=y, labels = text, pos=3, ...)
  dev.off()
  img <- readImage("temp.png")
  unlink("temp.png")
  par(.pardefault)
  img
}