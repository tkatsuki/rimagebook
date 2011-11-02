f <- system.file("images/lena.tif", package="RImageBook")
lena <- readImage(f)
display(lena)
lenab <- readTiff(f)
plot(lenab)
?biOps
?EBImage
plot(lenab)
dev.new()                               # 新しいウィンドウを開く 
plot(imgCrop(lenab, 70, 150, 300, 300)) # 画像の切り出し
dev.new()
plot(imgEKMeans(lenab,4))               # K-meansクラスタリングによる階調削減
dev.new()
plot(imgDifferenceEdgeDetection(imgRGB2Grey(lenab))) # エッジ検出
writeImage(lena, "lena.png")
writeImage(lena, "lena1.jpg", quality=1)
writeImage(lena, "lena10.jpg", quality=10)
writeImage(lena, "lena50.jpg", quality=50)
writeImage(lena, "lena100.jpg", quality=100)
writeImage(lena, "lena.tiff")
display(readImage("lena1.jpg"))
display(readImage("lena10.jpg"))
display(readImage("lena50.jpg"))
display(readImage("lena100.jpg"))
display(readImage("lena.png"))
file.info("lena.tiff")$size
file.info("lena.png")$size
file.info("lena100.jpg")$size
identical(readImage("lena.png"), readImage("lena.tiff"))
lenag <- channel(lena, "gray")   # グレースケールに変換
lenag[100:150, 200:300] <- 0     # 画素値を0に変更
display(lenag)                   # 画像を表示
lenabg <- imgRGB2Grey(lenab)     # グレースケールに変換
lenabg[100:150, 200:300] <- 0    # 画素値を0に変更
plot(lenabg)                     # 画像を表示
lenab2 <- EBI2biOps(lena)
lena2 <- biOps2EBI(lenab2) # imagedataクラスからImageクラスへ変換
identical(lena, lena2)
