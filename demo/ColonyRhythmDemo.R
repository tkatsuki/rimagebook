dir <- system.file("images/p2", package="RImageBook")
filelist <- list.files(dir, pattern=".tiff")
# ファイルリスト中のすべてのファイルにreadImageを適用し，リスト形式で保持
images <- lapply(filelist, function(x) readImage(paste(dir, "/", x, sep="")))
w <- nrow(images[[1]])
h <- ncol(images[[1]])
                            # 画像のリストをスタック画像に変換する
images <- array(unlist(images), c(w, h, length(filelist)))
imagea <- medianPrj(images) # 中央値で時間軸方向に投射する
display(normalize(imagea))  # マスターマスクを表示
                       # 閾値処理でコロニーのマスクを作る
mask1 <- thresh(imagea, 10, 10, 0.00003)
display(mask1)
                       # コロニーのある部分だけを切り出すために円形のマスクを作る
mask2 <- matrix(0, 512, 512)
mask2 <- drawCircle(mask2, 250, 260, 190, col=1, fill=TRUE)
display(mask2)
mask3 <- mask1 * mask2 # 円形のマスクを使って切り出し
display(mask3)
mask3 <- bwlabel(mask3)       # 形状特徴パラメータを得るためにラベル化する
hf <- hullFeatures(mask3)     # 形状特徴パラメータの取得
                              # オブジェクトのサイズと円形率でフィルタをかける
id <- which(hf[,'g.s'] < 10 | hf[,'g.s'] > 100 | hf[,'g.acirc'] > 0.1)
mask3 <- rmObjects(mask3, id) # 上記条件に一致するオブジェクトを削除する
mask3 <- mask3 > 0            # 再ラベル化のためにいったんラベルをクリア
mask3 <- bwlabel(mask3)       # 再ラベル化
hf <- hullFeatures(mask3)                # 再度形状特徴パラメータを取得
labels  <- as.character(c(1:max(mask3))) # コロニーの番号を作る
xy <- hf[,c('g.x','g.y')]                # コロニーの座標を得る
xy <- xy +5                              # 視認性向上のため座標を5ピクセル移動
                                         # コロニーの番号を画像に表示
display(drawtext(mask3, xy, labels=labels, col="white"))
# cmoment()関数をスタックに適用するためにマスクもスタック化する
mask4 <- array(mask3, dim=c(w, h, dim(images)[3]))
m <- cmoments(mask4, images) # 中央モーメントを計算
                             # 各コロニーの単位面積あたりの輝度を計算
result <- sapply(m, function(x) x[,"m.int"]/x[,"m.pxs"])
result <- t(result) # データを転置して各行がコロニーの番号となるようにする
nresult <- apply(result, 2, function(x) x/min(x)) # データを正規化する
                    # matplot()関数でプロットする際のx軸データを準備
x <- matrix(c(1:nrow(result))*2, nrow(result), ncol(result))
                    # 全コロニーのデータを表示
matplot(x, result, xlab="hours", ylab="A.U.", type="l") 
                    # 正規化したデータを表示
matplot(x, nresult, xlab="hours", ylab="A.U.", type="l")
                    # 全データの平均を表示
matplot(rowMeans(x), rowMeans(result), xlab="hours", ylab="A.U.", type="l") 
set.seed(10)                    # 乱数生成用の種を設定（再現性のため）
res <- wc((result*2^16)^2, 0.5) # waveclockパッケージを用いて周期性を抽出する
dev.off()                                  # 作図領域をリセット
hist(res[,1], xlim=c(20, 30), xlab="period (hr)", 
     ylab="frequency", breaks=30, main="") # 結果をプロット
# 周期が27時間より大きいコロニーをラベル
matplot(x[,which(res[,1] > 27)], result[,which(res[,1] > 27)], 
        xlab="hours", ylab="A.U.", type="l")
res0 <- replace(res, which(is.na(res)), 0) # データ中のNAを0で置き換える
# オブジェクトの輝度値を周期の値で置き換える
for (i in 1:length(res[,1])){
  mask3[which(mask3==i)] <- res0[i,1]
} 
# 疑似カラー表示の範囲を決めるため，周期の最小値を調べる
min <- floor(255*sort(unique(as.vector(normalize(mask3))))[2])
mask4 <- pseudoColor2(normalize(mask3), min-1, 255) # 疑似カラー化
display(mask4)
rainbowbar <- rainbowBar(100, 20) # カラースケールの作成
bns <- rotate(rainbowbar, -90) 
                                  # 表示用の文字を作成
minchr <- as.character(round(sort(unique(as.vector(mask3)))[2]))
maxchr <- as.character(round(max(as.vector(mask3)))) 
                                  # 画像にカラースケールを埋め込む
mask4[(w-30):(w-30+nrow(bns)-1), 20:(20+ncol(bns)-1), 1:3] <- bns
                                  # カラースケールのメモリを描く
arial <- drawfont(family="arial", size=10)
mask4 <- drawtext(mask4, c(w-45, (25+ncol(bns))), minchr, col="white", 
                  font=arial)
mask4 <- drawtext(mask4, c(w-45, 20), maxchr, col="white", font=arial)
display(mask4)                    # 結果を表示