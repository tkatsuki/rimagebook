## Demo for p.27 Fig.3.1
monalisa <- readImage(system.file("images/MonaLisa.jpg", package="RImageBook"))
display(monalisa, "Original image")
display(resize(monalisa, 600), "Zoom in")
display(resize(monalisa, 200), "Zoom out")
display(resize(monalisa, 512, 300), "Squeeze")

## Demo for p.27 Fig.3.2
display(rotate(monalisa, 45), "Rotating 45 degrees clock wise")
display(rotate(monalisa, 90), "Rotating 90 degrees clock wise")

## Demo for p.28 Fig.3.3
motor <- readImage(system.file("images/motorcycle.jpg", package="RImageBook"))
motorpad <- padding(motor, 20, 10)
display(motor, "Original image")
display(motorpad, "Padded image")

## Demo for p.29 Fig.3.4
display(flip(monalisa), "Flipping")
display(flop(monalisa), "Flopping")
display(flip(rotate(monalisa, 90)), "Reflection about y = x")

## Demo for p.31 Fig.3.6
display(skew(monalisa, 0, 10), "Skewing 10 degrees along x axis")
display(skew(monalisa, 0, -10), "Skewing -10 degrees along x axis")
display(skew(monalisa, 10), "Skewing 10 degrees along y axis")

## Demo for p.31 Fig.3.7
display(translate(monalisa, c(20, 40)), "Translation")
monalisab <- EBI2biOps(monalisa)
plot(imgTranslate(monalisab, 100, 100, 200, 200, 100, 100))

## Demo for p.33
if(!require(bitops)){
  install.packages("bitops")
  library("bitops")
}
if(!require(RNiftyReg)){
  install.packages("RNiftyReg")
  library("RNiftyReg")
}
if(!require(oro.nifti)){
  install.packages("oro.nifti")
  library("oro.nifti")
}
x <- channel(monalisa, "gray")
ytheta <- 10
xpad <- tan(ytheta*pi/180)*ncol(x)
x <- rbind(matrix(0, xpad, ncol(x)), x)
xn <- as.nifti(x)
aff <- matrix(c(1,tan(ytheta*pi/180),0,0,0,1,0,0,0,0,1,0,0,0,0,1), 4, 4, byrow=TRUE)
aff
xreg <- applyAffine(aff, xn, xn, "nifty")
display(xreg$image, "Affine transformation")

## Demo for p.34 Fig.3.9
pr <- pyramid(monalisa, 3)
str(pr)
display(pr[[1]], "Image pyramid 1/1")
display(pr[[2]], "Image pyramid 1/2")
display(pr[[3]], "Image pyramid 1/4")
