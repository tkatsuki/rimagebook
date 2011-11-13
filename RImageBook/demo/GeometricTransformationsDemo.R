monalisa <- readImage(system.file("images/MonaLisa.jpg", package="RImageBook"))
display(resize(monalisa, 600))
display(resize(monalisa, 200))
display(resize(monalisa, 512, 300))

display(rotate(monalisa, 45))
display(rotate(monalisa, 90))

motor <- readImage(system.file("images/motorcycle.jpg", package="RImageBook"))
motorpad <- padding(motor, 20, 10)
display(motorpad)

display(flip(monalisa))
display(flop(monalisa))
display(flip(rotate(monalisa, 90)))

display(skew(monalisa, 0, 10))
display(skew(monalisa, 0, -10))
display(skew(monalisa, 10))

display(translate(monalisa, c(20, 40)))

monalisab <- EBI2biOps(monalisa)
plot(imgTranslate(monalisab, 100, 100, 200, 200, 100, 100))

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
pr <- pyramid(monalisa, 3)
str(pr)
display(pr[[1]])