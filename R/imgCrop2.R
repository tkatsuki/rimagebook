cropImage <- function(img){
plot(img)
loc<-locator(2, type="p", pch=3) # 場所を2点選ぶ
if (loc$x[1] < loc$x[2] && loc$y[1] > loc$y[2]) {
  return(imgCrop(img, loc$x[1], (nrow(img)-loc$y[1]),
    abs(loc$x[2]-loc$x[1]), abs(loc$y[2]-loc$y[1])))
}
if (loc$x[1] > loc$x[2] && loc$y[1] > loc$y[2]) {
  return(imgCrop(img, loc$x[2], (nrow(img)-loc$y[1]),
    abs(loc$x[2]-loc$x[1]), abs(loc$y[2]-loc$y[1])))
}
if (loc$x[1] < loc$x[2] && loc$y[1] < loc$y[2]) {
  return(imgCrop(img, loc$x[1], (nrow(img)-loc$y[2]),
    abs(loc$x[2]-loc$x[1]), abs(loc$y[2]-loc$y[1])))
}
if (loc$x[1] > loc$x[2] && loc$y[1] < loc$y[2]) {
  return(imgCrop(img, loc$x[2], (nrow(img)-loc$y[2]),
    abs(loc$x[2]-loc$x[1]), abs(loc$y[2]-loc$y[1])))
}
}