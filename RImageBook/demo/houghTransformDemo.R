library(PET)
shapesr <- flip(shapes[151:500,1:350]) # 正方形を切り抜く
ThetaSamples <- 721 # thetaのサンプリング数 
rhosamples <- 2*round(sqrt(sum((dim(shapesr))^2))/2)+1 # rhoのサンプリング数
rhomin <- -0.5*((2*round(sqrt(sum((dim(shapesr))^2))/2)+1)-1)
drho <- (2*abs(rhomin)+1)/rhosamples # rhoのサンプリング間隔
hb <- hough(shapesr,　ThetaSamples=ThetaSamples) # ハフ変換の実行
# 変換後の結果表示
image(hb$hData, col=gray((0:32)/32), axes = FALSE, xlab="", ylab="")
# 上位10%のピークを拾う
peak <- which(hb$hData[]>(max(hb$hData[])*0.9), arr.ind=TRUE) 
# 元の画像を表示
windows()
image(1:nrow(shapesr), 1:ncol(shapesr), shapesr, 
      col = terrain.colors(100), axes = FALSE, xlab="", ylab="")
# 元の画像に検出された直線を上書き
for (i in 1:nrow(peak)){
  the <- peak[i,1]*pi/ThetaSamples
  rho <- (peak[i,2]+rhomin)/drho
  curve(-(x-(nrow(shapesr)-1)*0.5)/tan(the)+rho/sin(the)+0.5*(ncol(shapesr)-1), 
         0, 350, xlab="", ylab="", xlim=c(0, 350), ylim=c(0, 350), add=TRUE)
} 