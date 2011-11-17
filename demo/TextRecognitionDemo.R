library(e1071)
library(rpart)
con <- file("ETL1C_01", open="rb") # ファイルを開く
# ファイルからraw形式でバイナリデータを読み込む
# 読み込むデータのサイズはファイル全体とする
rawdata <- readBin(con, "raw", 
                   file.info("ETL1C_01")$size)
close(con) # ファイルを閉じる
fn <- length(rawdata)/2052
w <- 64
h <- 63
imgs <- array(0, dim=c(w, h, fn))
char <- rep(0, fn)
for(i in 1:fn){
  char[i] <- rawToChar(rawdata[(2052*(i-1)+3):(2052*(i-1)+4)])
  img <- rawdata[(2052*(i-1)+34):(2052*(i-1)+2049)]
  N <- length(img)
  a <- matrix(0, 2, N)
  img <-  as.integer(img)
  a[1, 1:N] <- img%/%16
  a[2, 1:N] <- img%%16
  a <- matrix(a, w, h)
  imgs[,,i] <- a
}
rm(rawdata) # メモリの節約のため不要なオブジェクトは削除
gdat <- matrix(resize(imgs, 16, 16), fn, 16*16)
mask <- thresh(imgs, 10, 10, 2)
mask <- bwlabel(mask)
mm <- cmoments(mask, mask)
sm <- sapply(mm, function(x) which(x[,'m.pxs'] < 10))
mask <- rmObjects(mask, sm)
mask <- mask > 0
zdat <- zernikeMoments(mask, imgs)
rm(imgs)
invid <- which(apply(mask, 3, sum)==0)
zdat <- data.frame(matrix(unlist(zdat), nrow=length(zdat), byrow=T))
zdat <- data.frame("char" = char, "zftrs" = zdat)
gdat <- data.frame("char" = char, "gftrs" = gdat)
zdat <- zdat[-invid,]
gdat <- gdat[-invid,]
rm(mask)
index <- 1:nrow(zdat)
testindex <- sample(index, trunc(length(index)/3))
ztestset <- zdat[testindex, ]
ztrainset <- zdat[-testindex, ]
gtestset <- gdat[testindex, ]
gtrainset <- gdat[-testindex, ]
svm.model.z <- svm(char ~ ., data = ztrainset)
svm.model.g <- svm(char ~ ., data = gtrainset)
#tuning <- tune.svm(char ~ ., data = zdat, gamma = c(1/100, 1/50, 1/25), 
#                    cost = c(2, 4, 8), 
#                    tunecontrol = tune.control(sampling = "boot"))
svm.pred.z <- predict(svm.model.z, ztestset[, -1])
svm.pred.g <- predict(svm.model.g, gtestset[, -1])
tbsvmz <- table(pred = svm.pred.z, true = ztestset[, 1])
tbsvmg <- table(pred = svm.pred.g, true = gtestset[, 1])
round(prop.table(tbsvmz, 1), 2)*100

round(prop.table(tbsvmg, 1), 2)*100

svm.z <- svm(char ~ ., data = zdat, cross=10)
svm.g <- svm(char ~ ., data = gdat, cross=10)
summary(svm.z)
summary(svm.g)