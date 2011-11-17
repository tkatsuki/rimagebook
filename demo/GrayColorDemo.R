grayiris <- readImage(system.file("images/iris_gray.jpg", package="RImageBook"))
grayiris
iris <- readImage(system.file("images/iris.jpg", package="RImageBook"))
iris
irisr <- channel(iris, "red")
irisg <- channel(iris, "green")
irisb <- channel(iris, "blue")
display(irisr)
display(irisg)
display(irisb)
irisgbr <- rgbImage(irisg, irisb, irisr)
display(irisgbr)
iriseg <- channel(iris, "grey")
irisb <- EBI2biOps(iris)
irisbg <- imgRGB2Grey(irisb)
display(iriseg)
display(biOps2EBI(irisbg))

nuc <- readImage(system.file("images/nuclei.tif", package="EBImage"))
nuc <- nuc[,,1]                       # スタック画像から1枚目の画像を抜き出す
nucps <- pseudoColor(nuc)             # 疑似カラー化
display(nucps)
nucps2 <- pseudoColor2(nuc, 100, 255) # グレースケールの一部を疑似カラー化
display(nucps2)