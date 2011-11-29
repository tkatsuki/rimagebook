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
display(irisr, "Red channel")
display(irisg, "Green channel")
display(irisb, "Blue channel")

## Demo for p.50 Fig.4.3
irisgbr <- rgbImage(irisg, irisb, irisr)
display(irisgbr, "RGB to GBR conversion")

## Demo for p.51 Fig.4.4
iriseg <- channel(iris, "grey")
irisb <- E2b(iris)
irisbg <- imgRGB2Grey(irisb)
display(iriseg, "Grayscaling using channel()")
display(b2E(irisbg), "Grayscaling using imgRGB2Grey()")

## Demo for p.52 Fig.4.7
nuc <- readImage(system.file("images/nuclei.tif", package="EBImage"))
nuc <- nuc[,,1]
display(nuc, "Original image")
nucps <- pseudoColor(nuc)
display(nucps, "Pseudocoloring")
nucps2 <- pseudoColor2(nuc, 100, 255)
display(nucps2, "Partial pseudocoloring")
