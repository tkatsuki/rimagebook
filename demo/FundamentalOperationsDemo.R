f <- system.file("images/lena.tif", package="RImageBook")
lenab <- readTiff(f)
plot(lenab)
dev.new()                               # 新しいウィンドウを開く 
plot(imgCrop(lenab, 70, 150, 300, 300)) # 画像の切り出し
dev.new()
plot(imgEKMeans(lenab,4))               # K-meansクラスタリングによる階調削減
dev.new()
plot(imgDifferenceEdgeDetection(imgRGB2Grey(lenab))) # エッジ検出