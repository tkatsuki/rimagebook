## Demo for p.48 Fig.4.1
grayiris <- readImage(system.file("images/iris_gray.jpg", package="RImageBook"))
grayiris
display(grayiris)

## Demo for p.49 Fig.4.2
iris <- readImage(system.file("images/iris.jpg", package="RImageBook"))
iris
irisr <- channel(iris, "red")
irisg <- channel(iris, "green")
irisb <- channel(iris, "blue")
display(irisr)
display(irisg)
display(irisb)

## Demo for p.50 Fig.4.3
irisgbr <- rgbImage(irisg, irisb, irisr)
display(irisgbr)

## Demo for p.51 Fig.4.4
iriseg <- channel(iris, "grey")
irisb <- EBI2biOps(iris)
irisbg <- imgRGB2Grey(irisb)
display(iriseg)
display(biOps2EBI(irisbg))

## Demo for p.52 Fig.4.7
nuc <- readImage(system.file("images/nuclei.tif", package="EBImage"))
nuc <- nuc[,,1]
nucps <- pseudoColor(nuc)
display(nucps)
nucps2 <- pseudoColor2(nuc, 100, 255)
display(nucps2)
