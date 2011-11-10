EBI2biOps <- function(img){
  img <- img*255
  img <- imagedata(img)
  img <- imgRotate90Clockwise(imgVerticalMirroring(img))
  return(img)
}
