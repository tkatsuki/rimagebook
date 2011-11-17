bg <- matrix(0, 256, 256)
display(bg)
grad <- matrix(c(0:255)/255, 256, 256)
display(grad)
x <- 0:65535
wave <- matrix(sin(x*pi/63.7), 256, 256)
display(wave)
w <- 256
h <- 256
s <- 40                                           # \(\sigma\)を指定
fn <- function(x, y, s) exp(-(x^2+y^2)/(2*s^2))   # 関数を定義
x <- seq(-floor(w/2), floor(w/2), len=w)          # x座標の範囲
y <- seq(-floor(h/2), floor(h/2),len=h)           # y座標の範囲
w <- outer(x, y, fn, s)                           # 一般化外積関数
display(normalize(w))
bg <- matrix(0, 256, 256)                        # 背景の作成
cr <- drawCircle(bg, 100, 100, 50, 1)            # 円周を描く
cr <- drawCircle(cr, 160, 160, 20, 1, fill=TRUE) # 塗りつぶした円を描く
display(cr)
theta <- seq(0, 2 * pi, length=(100))
x <- 200 + 100 * cos(theta)
y <- 200 + 30 * sin(theta)
plot(x, y, type = "l")
par(plt=c(0, 1, 0, 1), xaxs="i", yaxs="i") # 作図設定を変更
theta <- seq(0, 2 * pi, length=(100))
x <- 200 + 100 * cos(theta)
y <- 200 + 30 * sin(theta)
                                           # 出力先をpngファイルに設定
png(filename = "temp.png", width = 400, height = 400, bg = "black")
                                           # 作図する
plot(x, y, type = "l", axes=F, col="white", xlim=c(0, 400), ylim=c(0, 400))
dev.off()                                  # ファイルへの出力を完了
img <- readImage("temp.png")               # 出力したファイルを読み込んで確認
display(img)
library("shape")
par(plt=c(0, 1, 0, 1), xaxs="i", yaxs="i")
png(filename = "temp.png", width = 400, height = 400, bg = "black")
emptyplot(xlim = c(0, 400), ylim = c(0, 400))
filledellipse(rx1 = 100, ry1 = 200, mid = c(200, 200), 
              angle = 30, col = "white")
filledellipse(rx1 = 100, ry1 = 100, rx2 = 50, ry = 50, 
              mid = c(200, 200), col = "gray")
dev.off()
img <- readImage("temp.png")
display(img)