## Demo for p.68 Fig.4.21
girl <- readImage(system.file("images/girl.bmp",package="RImageBook"))
woman <- readImage(system.file("images/WOMAN.bmp",package="RImageBook"))
x <- matrix(0, nrow=256, ncol=256)
y <- matrix(1, nrow=256, ncol=256)
mask <- drawCircle(x, 130, 110, 60, col=1, fill=TRUE)
invmask <- drawCircle(y, 130, 110, 60, col=0, fill=TRUE)
girlface <- girl * mask
womanhole <- woman * invmask
display(girl)
display(woman)
display(mask)
display(invmask)
display(girlface)
display(womanhole)
display(girlface + womanhole)
