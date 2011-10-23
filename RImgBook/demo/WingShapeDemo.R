
library("shapes")
xy <- c()
for (i in 1:5){
  img <- readImage(system.file("images/wildwg.png", package="RImageBook"))
  img <- EBI2biOps(img)
  plot(img)
  xy[[i]] <- locator(8, type="p")　# 図12.12(a)のように8カ所の交差点を選択
  xy[[i]] <- do.call("cbind", xy[[i]])
  print(paste("Image", i, "finished.", sep=" "))
}
xywt <- abind::abind(xy, along=3)
xywtpc <- procGPA(xywt)
xy <- c()
for (i in 1:5){
  img <- readImage(system.file("images/gadwg.png", package="RImageBook"))
  img <- EBI2biOps(img)
  plot(img)
  xy[[i]] <- locator(8, type="p")
  xy[[i]] <- do.call("cbind", xy[[i]])
  print(paste("Image", i, "finished.", sep=" "))
}
xymt <- abind::abind(xy, along=3)
xymtpc <- procGPA(xymt)
tpsgrid(xywtpc$mshape, xymtpc$mshape, mag=5)
detach("package:shapes")