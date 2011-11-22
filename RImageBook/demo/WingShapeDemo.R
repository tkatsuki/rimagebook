## Demo for p.188 Fig.12.12
if(!require(shapes)){
  install.packages("shapes")
  library("shapes")
}
xy <- c()
for (i in 1:5){
  img <- readImage(system.file("images/wildwg.png", package="RImageBook"))
  img <- EBI2biOps(img)
  plot(img)
  xy[[i]] <- locator(8, type="p")
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
