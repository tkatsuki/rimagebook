subtractBg <- function(img, r=20){
plot(img) # 画像の表示
loc<-locator(1, type="p", pch=3) # 場所を1点選ぶ
bg_area  <-  imgCrop(img, (loc$x[1]-r), (nrow(img)-loc$y[1]-r),  2*r,  2*r)
bg_ave  <-  sum(as.vector(bg_area))/length(as.vector(bg_area))
img <- img - bg_ave
img2 <- replace(img, which(img<0), 0)
return(img2)
}