logod <- distmap(logo, metric=c('euclidean')) # 距離地図の作成
display(normalize(logod))                     # 規格化して表示
logol <- bwlabel(logo)    # ラベル化
max(logol)                # 最大輝度を調べる（オブジェクトの個数と等しい）

display(normalize(logol)) # 規格化して表示
logolr <- rmObjects(logol, 3) # 3のラベルがついたオブジェクトを削除
display(logolr)
logol2 <- reenumerate(logolr) # 再ラベル化
display(normalize(logol2))
max(logol2)                   # 再ラベル化の確認

logolr <- rmObjects(logol, 3) # 3のラベルがついているオブジェクトを削除
logolr <- logolr > 0          # ラベルの残っているオブジェクトを白画素とする
logol2 <- bwlabel(logolr)     # 再ラベル化
max(logol2)

x <- matrix(0, 400, 400)                           # 背景の作成
y <- drawCircle(x, 100, 200, 60, col=1, fill=TRUE) # 円を描く
z <- drawCircle(y, 200, 200, 60, col=1, fill=TRUE) # 円を追加
display(z)                       # 融合した二つの円のマスク画像
w <- distmap(z)                  # 距離地図を作成
wt <- watershed(w)               # watershed処理で領域分割
display(normalize(w))            # 距離地図を表示
display(normalize(wt))           # 分割の結果を表示
gel <- readImage(system.file("images/ima7.gif", package="RImageBook"))
display(1-gel)                                 # 階調反転
gelbw <- thresh(1-gel, w=8, h=8, offset=0.01)  # 閾値処理
display(gelbw)
kern <- makeBrush(3, shape="diamond")          # 構造要素の作成
gelbwsm <- closing(opening(gelbw, kern), kern) # オープニングとクロージングによるノイズ除去
display(gelbwsm)
geldist <- distmap(gelbwsm)                    # 距離地図の作成
display(normalize(geldist))
gelwsh02 <- watershed(geldist, tolerance=0.2)  # watershedによる分割
gelwsh10 <- watershed(geldist, tolerance=1)
gelwsh40 <- watershed(geldist, tolerance=4)
gelresult <- combine(normalize(gelwsh02),      # 画像のスタック化
                     normalize(gelwsh10),
                     normalize(gelwsh40))
display(gelresult)
x <- matrix(0, 400, 400)
y <- drawCircle(x, 100, 200, 60, col=1, fill=TRUE)
z <- drawCircle(y, 250, 200, 120, col=1, fill=TRUE)
display(z, title="original")
dm <- distmap(z)                  # 距離地図の作成
display(normalize(dm))
wsh <- watershed(dm)              # watershed法による分割
display(normalize(wsh), title="watershed")
peaks <- findPeaks(dm)                  # 距離画像からピークを検出
display(normalize(peaks), title="peaks")
seg1 <- propagate(z, bwlabel(peaks), z) # ボロノイ分割
display(normalize(seg1), title="segmentaion by peak seeds")
peakval <- dm * peaks          # 距離地図から各ピークの値を抽出する
# ピークの最小値（小さいほうの円のピーク値）を求める
# [2]とするのは0より大きい最小値を求めるため
min2 <- sort(unique(as.vector(peakval)))[2] 
seeds <- dm >= min2            # 小さいほうの円のピーク値で2値化する
seeds <- bwlabel(seeds)        # ラベル化して母点として使う準備をする
display(normalize(seeds), title="seeds")
seg2 <- propagate(z, seeds, z) # ボロノイ分割を行う
display(normalize(seg2), title="new segmentation")
