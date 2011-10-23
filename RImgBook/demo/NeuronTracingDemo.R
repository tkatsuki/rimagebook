# LSMファイル形式の画像データを読み込む
img <- readLsm("../image/color/R3EmRFP.lsm")
display(img)                            # 画像データを表示
ch3b <- EBI2biOps(img[,,3])             # 3チャネル目をbiOps形式に変換
ch3bm <- imgBlockMedianFilter(ch3b, 5)  # 中央値フィルタでノイズを除去
ch3m <- biOps2EBI(ch3bm)                # EBImage形式に変換
ch3th <- thresh(ch3m, 50, 50, 0.06)     # 2値化
display(ch3th)
ch3bw <- bwlabel(ch3th)                 # ラベル化
mm <- cmoments(ch3bw, ch3bw)            # 中心モーメントの計算
                                        # 最大のオブジェクト以外を消去
ch3bw <- rmObjects(ch3bw, which(mm[,'m.pxs']!=max(mm[,'m.pxs'])))
ch3bw <- ch3bw > 0                      # 再度2値化
ske <- thinning(ch3bw)                  # 細線化
display(normalize(ske + ch3bw))         # 細線と元画像の重ね合わせを表示
ends <- ending(ske)         # 端点の検出
branches <- branch(ske)     # 分岐点の検出
length(which(ends==1))      # 端点数

length(which(branches==1))  # 分岐点の数

distimg <- distmap(ch3bw)   # 距離地図の作成
                            # 距離地図中の最大値の座標を抽出
peakpos <- which(distimg == max(distimg), arr.ind=TRUE)
peakpos


x <- ske                           # 細線を変数xにコピーする
px <- which(x==1, arr.ind=TRUE)    # 細線上のすべての座標を得る
pxnm <- which(x==1)                # 細線の部分の要素番号も得ておく
pxpeak <- rbind(px, peakpos)       # 細線の座標にピークの座標を追加 
peakmat <- as.matrix(dist(pxpeak)) # 距離行列を計算する
                                   # ピークから最端距離にある画素を探す
peakcoord <- which(peakmat[nrow(pxpeak),(1:(nrow(pxpeak)-1))] == 
                   sort(peakmat[nrow(pxpeak),(1:(nrow(pxpeak)-1))])[1])
peakcoord


library(igraph)
pxdist <- as.matrix(dist(px[,]))          # すべての白画素間の距離行列を作成
pxdist[which(pxdist[,] >= 2)] <- 0        # 8近傍以外は接続していないものとする
pxdist[which(pxdist[,] == 1)] <- 0.5      # 4近傍の距離を0.5とする
g <- graph.adjacency(pxdist, weight=TRUE) # グラフ・オブジェクトを生成
endcoord <- which(ends == 1)       # 端点の要素番号を得る
endpx <- which(pxnm %in% endcoord) # 細線中の要素番号に変換
                                 # 最短経路の探索
paths <- get.shortest.paths(g, peakcoord-1, endpx-1) 
                                 # 最長の最短経路を選ぶ
maxpath <- paths[[which.max(sapply(paths, length))]]
maxpath <- unlist(maxpath)       # リストをベクトルに直す
                                 # グラフのインデックスを画素の座標に変換
pathcoord <- px[c(maxpath+1),] 
                                 # 座標を要素番号に直す
num <- pathcoord[,1] + (pathcoord[,2]-1)*nrow(x) 
x[num] <- 3                      # 細線中の該当する画素の値を変更
display(normalize(x))            # 結果の細線を表示
display(img[,,1])            # 元データの1チャネル目を表示
ch1b <- EBI2biOps(img[,,1])  # biOps形式に変換 
ch1bm <- imgBlockMedianFilter(ch1b, 5) # 中央値フィルタでノイズ除去
ch1m <- biOps2EBI(ch1bm)     # EBImage形式に変換
display(ch1m)
                             # チャネル3に対する相対値としてプロット
plot(ch1m[num]/ch3m[num], ylab="Relative Intensity", type="l")