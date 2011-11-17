monalisa <- readImage(system.file("images/MonaLisa.jpg", package="RImageBook"))
display(resize(monalisa, 600))       # 拡大して表示
display(resize(monalisa, 200))       # 縮小して表示
display(resize(monalisa, 512, 300))  # スクイーズして表示

display(rotate(monalisa, 45)) # 時計回りに45度回転して表示
display(rotate(monalisa, 90)) # 時計回りに90度回転して表示

motor <- readImage(system.file("images/motorcycle.jpg", package="RImageBook"))
motorpad <- padding(motor, 20, 10) # パディングを行う
display(motorpad)

display(flip(monalisa))             # x軸に関する鏡像変換
display(flop(monalisa))             # y軸に関する鏡像変換
display(flip(rotate(monalisa, 90))) # 直線y = xに関する鏡像変換

display(skew(monalisa, 0, 10))
display(skew(monalisa, 0, -10))
display(skew(monalisa, 10))

display(translate(monalisa, c(20, 40)))

monalisab <- EBI2biOps(monalisa)
plot(imgTranslate(monalisab, 100, 100, 200, 200, 100, 100))

require(RNiftyReg)
require(bitops)
require(oro.nifti)
x <- channel(monalisa, "gray")          # モナリザの画像データをxにコピー
ytheta <- 10                            # y軸とのなす角は10度
xpad <- tan(ytheta*pi/180)*ncol(x)      # x軸方向のパディングを計算
x <- rbind(matrix(0, xpad, ncol(x)), x)
xn <- as.nifti(x)                       # NIfTY形式に変換
aff <- matrix(c(1,tan(ytheta*pi/180),0,0,0,1,0,0,0,0,1,0,0,0,0,1), 
                 4, 4, byrow=TRUE)       # アフィン変換の行列を作成
aff                                      # 行列を確認
xreg <- applyAffine(aff, xn, xn, "nifty")        # 画像を変換
display(xreg$image)                     # 画像データを表示
pr <- pyramid(monalisa, 3) # 画像ピラミッドを作成
str(pr)
display(pr[[1]])           # 1段目の縮小画像を表示（以降省略）