require(RImageBook)
img1 <- readImage(system.file("images/frame159.jpeg",package="RImageBook"))
img2 <- readImage(system.file("images/frame160.jpeg",package="RImageBook"))
ft1 <- GoodFeaturesToTrack(img1, 200) # 特徴点の自動検出
res <- OpticalFlow(img1, img2, ft1)   # オプティカルフローの計算
ft1 <- ft1[1:2,res[3,]>0]             # 検出成功した点以外をフィルタリング
res <- res[1:2,res[3,]>0]
# 以下，結果の作図
oldpar <- par(no.readonly = TRUE)
png(filename = "temp.png", width = nrow(img1), 
    height = ncol(img1), bg = "black")
par(plt=c(0, 1, 0, 1), xaxs="i", yaxs="i")
plot(t(ft1)[,1], ncol(img1)-t(ft1)[,2], axes=F, pch=20, 
     col="white", xlim=c(0, nrow(img1)), ylim=c(0, ncol(img1)))
arrows(t(ft1)[,1], ncol(img1)-t(ft1)[,2], t(res)[,1], ncol(img1)-t(res)[,2], 
       col="white", length=0.02)
dev.off()
img <- readImage("temp.png")
display(img1 + img)
unlink("temp.png")
par(oldpar)