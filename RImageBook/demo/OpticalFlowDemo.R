pen <- readImage(system.file("images/pendulum.gif", package="RImageBook"))
img0 <- pen[,,1]
img1 <- pen[,,4]
ftr <- GoodFeaturesToTrack(img0, 200)
res <- OpticalFlow(img0, img1, ftr, 40)
ftr <- ftr[1:2, res[3,]>0]
res <- res[1:2, res[3,]>0]
w <- nrow(img0)
h <- ncol(img0)
png(filename = "temp.png", width = w, height = h, bg = "black")
par(plt=c(0, 1, 0, 1), xaxs="i", yaxs="i")
plot(t(ftr)[,1], h - t(ftr)[,2], axes=F, pch=20, 
     col="white", xlim=c(0, w), ylim=c(0, h))
arrows(t(ftr)[,1], h-t(ftr)[,2], t(res)[,1], h-t(res)[,2], 
       col="white", length=0.02)
dev.off()
img <- readImage("temp.png")
display(img)
img0[img0 == 0] <- 0.5
display((1-img) * img0)
unlink("temp.png")