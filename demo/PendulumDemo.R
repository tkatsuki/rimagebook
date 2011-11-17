# 動画データの読み込み
pen <- readImage(system.file("images/pendulum.gif", package="RImageBook"))
pen <- 1-pen                        # 白黒反転
pen <- thresh(pen, 50, 50, 0.5)     # 2値化
kern1 <- makeBrush(3, shape="disc") # 構造要素の作成
pen2 <- opening(pen, kern1)         # オープニング処理
pend <- bwlabel(pen2)               # ラベリング処理
mm <- cmoments(pend, pen)           # モーメントパラメータの取得
# サイズが300ピクセル以下でy座標が50以下のオブジェクトを選択
ll <- sapply(mm, function(x) which(x[,'m.pxs']<=300 | x[,'m.y']<=50))
pens <- rmObjects(pend, ll)         # 上記オブジェクトを削除
pens <- pens > 0                    # ラベルをリセット
pens <- bwlabel(pens)               # 再ラベル
display(pens)

a <- pen[,,6]       # 6フレーム目を抽出
b <- pen[,,8]       # 8フレーム目を抽出
c <- pen[,,10]      # 10フレーム目を抽出
display(abs(a-b))
display(abs(b-c))
display(abs(a-b) & abs(b-c))

a <- pen[,,6]
b <- pen[,,7]
c <- pen[,,8]
display(abs(a-b))
display(abs(b-c))
display(abs(a-b) & abs(b-c))

gr <- matrix(0:399, 400, 400)
for(i in 1:126) pens[,,i] <- pens[,,i]*gr
pens <- equalize(pens)
pens <- normalize(pens)
pens <- pens@.Data
pen2 <- pen * (1-pens)
a <- pen2[,,6]
b <- pen2[,,7]
c <- pen2[,,8]
display(abs(a-b))
display(abs(b-c))
display(abs(a-b) & abs(b-c))

mm <- cmoments(pens, pen) # 再度モーメントパラメータを取得
mm <- matrix(unlist(mm), ncol=4, byrow=TRUE) # リストを行列に整形
mm
                                           # 出力先をpng画像に設定
png(filename = "pendulumResult.png", width=400, height=400, bg="white")
par(plt=c(0, 1, 0, 1), xaxs="i", yaxs="i") # プロット領域の設定
plot(mm[,3], mm[,4], axes=F, xlim=c(0, 400), ylim=c(0, 400))
lines(mm[,3], mm[,4])                      # データを線でつなぐ
dev.off()                                  # ファイルに出力完了
                                           # 出力した画像を読み込む
resultimg <- readImage("pendulumResult.png")
resultimg <- flip(resultimg)               # 向きを合わせるために上下反転
# 元データの1フレーム目と解析結果を重ね合わせて表示
display(xor(resultimg, pen@.Data[,,1]))
