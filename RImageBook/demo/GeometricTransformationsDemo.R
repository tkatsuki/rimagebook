## Demo for p.27 Fig.3.1
monalisa <- readImage(system.file("images/MonaLisa.jpg", package="RImageBook"))
display(resize(monalisa, 600))
display(resize(monalisa, 200))
display(resize(monalisa, 512, 300))

## Demo for p.27 Fig.3.2
display(rotate(monalisa, 45))
display(rotate(monalisa, 90))

## Demo for p.28 Fig.3.3
motor <- readImage(system.file("images/motorcycle.jpg", package="RImageBook"))
motorpad <- padding(motor, 20, 10)
display(motorpad)

## Demo for p.29 Fig.3.4
display(flip(monalisa))
display(flop(monalisa))
display(flip(rotate(monalisa, 90)))

## Demo for p.31 Fig.3.6
## Requires RNiftyReg and oro.nifti packages
## install.packages("RNiftyReg")
## install.packages("oro.nifti")
display(skew(monalisa, 0, 10))
display(skew(monalisa, 0, -10))
display(skew(monalisa, 10))

## Demo for p.31 Fig.3.7
display(translate(monalisa, c(20, 40)))
monalisab <- EBI2biOps(monalisa)
plot(imgTranslate(monalisab, 100, 100, 200, 200, 100, 100))

## Demo for p.33
require(RNiftyReg)
require(bitops)
require(oro.nifti)
x <- channel(monalisa, "gray")
ytheta <- 10
xpad <- tan(ytheta*pi/180)*ncol(x)
x <- rbind(matrix(0, xpad, ncol(x)), x)
xn <- as.nifti(x)
aff <- matrix(c(1,tan(ytheta*pi/180),0,0,0,1,0,0,0,0,1,0,0,0,0,1), 4, 4, byrow=TRUE)
aff
xreg <- applyAffine(aff, xn, xn, "nifty")
display(xreg$image)

## Demo for p.34 Fig.3.9
pr <- pyramid(monalisa, 3)
str(pr)
display(pr[[1]])
display(pr[[2]])
display(pr[[3]])
