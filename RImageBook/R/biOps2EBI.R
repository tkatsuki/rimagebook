biOps2EBI <- function (img){
  img <- imgVerticalMirroring(imgRotate90CounterClockwise(img))
  if(length(dim(img))==3){
    img <- Image(img/255,,Color)
    } else {
      img <- Image(img/255,,Grayscale)
      }
  return(img)
}
