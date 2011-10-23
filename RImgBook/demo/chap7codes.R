cam <- readImage(system.file("images/Cameraman.bmp", package="RImageBook"))
cam <- EBI2biOps(cam)
histogram(cam)
cambw <- imgThreshold(cam, 75) # 75を閾値として2値化
plot(cambw) 
camkm <- imgKMeans(cam, 2) # \(k\)-平均法による2値化
plot(camkm)
unique(as.vector(camkm))

doc <- readImage(system.file("images/scan.JPG", package="RImageBook"))
docbw <- doc > 0.7                # 単純な閾値処理
docbw2 <- thresh(doc, 7, 7, -0.1) # thresh()関数による平均移動法
docbg <- gblur(doc, 20, 10)       # ガウシアンブラー
docfl <- doc - docbg               # 背景の減算
docflbw <- docfl > 0.001          # 単純な閾値処理
display(doc); display(docbw); display(docbw2);
display(docbg); display(docfl); display(docflbw) # docbw, docbw2, docbg, docflの表示は省略

shapes <- readImage(system.file("images/shapes.png", package="EBImage"))
logo <- shapes[110:512,1:130]                # ロゴ部分の切り出し
display(logo)
logob <- EBI2biOps(logo)                     # biOps形式に変換
logobn <- imgSaltPepperNoise(logob, 5)       # 画像にノイズを追加
logon <- biOps2EBI(logobn)                   # EBImage形式に変換
kern <- makeBrush(3, shape='diamond')        #　構造要素の作成
display(erode(logon, kern))                  # 膨張
display(dilate(logon, kern))                 # 収縮
display(opening(logon, kern))                # オープニング
display(closing(logon, kern))                # クロージング
display(closing(opening(logon, kern), kern)) # オープニング後クロージング
display(opening(closing(logon, kern), kern)) # クロージング後オープニング
logod <- distmap(logo, metric=c('euclidean')) # 距離地図の作成
display(normalize(logod))                     # 規格化して表示

logol <- bwlabel(logo)    # ラベル化
display(normalize(logol)) # 規格化して表示
max(logol)                # 最大輝度を調べる（オブジェクトの個数と等しい）

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
display(z)             # 融合した2つの円のマスク画像
w <- distmap(z)        # 距離地図を作成
wt <- watershed(w)     # watershed処理で領域分割
display(normalize(w))  # 距離地図を表示
display(normalize(wt)) # 分割の結果を表示

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

display(z, title="original")
dm <- distmap(z)     # 距離地図の作成
display(normalize(dm))
wsh <- watershed(dm) # watershed法による分割
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

shapesl <- bwlabel(shapes)     # ラベリング
ftrs <- hullFeatures(shapesl)  # マスクの特徴抽出
# 非真円度が0.05より小さく，平均半径が2より大きなもののラベル番号を取得
id <- which(ftrs[, 'g.acirc']<0.05 & ftrs[, 'g.pdm']>2)
# マスクのうち上記ラベル番号と合致するもの以外を0に置き換える
shapesl[is.na(match(shapesl, id))] <- 0  
display(shapesl)

shapess <- erode(shapes, makeBrush(3, shape="diamond")) # 収縮処理
shapese <- shapes - shapess                  # 元画像と収縮した画像の差分をとる
display(shapese)
contour(shapes, nlevels=2, drawlabels=FALSE) # contour()関数による輪郭表示
ocontour(shapes) 

ske <- skeletonize(logo)
display(ske)

logot <- thinning(logo)
display(logot)

logoends <- ending(logot)               # 端点の検出
display(dilate(logoends, makeBrush(3))) # 点を強調して表示
logotends <- dilate(logoends, makeBrush(3))*2 + logot # 細線と重ね合わせ
display(normalize(logotends))
length(which(logoends == 1)) 

logobr <- branch(logot)               # 分岐点の検出
display(dilate(logobr, makeBrush(3))) # 点を強調して表示
logotbr <- dilate(logobr, makeBrush(3))*2 + logot
display(normalize(logotbr))           # 細線と重ね合わせ
length(which(logobr == 1)) 

logotp <- pruning(logot, 4) # ひげの剪定
display(logotp)

board <- readImage(system.file("images/board.jpg", package="RImageBook"))
display(board)
bat <- board[155:215, 250:315]                # テンプレートを用意
display(bat)
sad <- SAD(board, bat)                        # SADを計算
display(normalize(sad))
minpeak <- which(sad==min(sad), arr.ind=TRUE) # SADの最小値の場所を求める
minpeak

sadres <- board                               # 元画像をコピーしておく 
sadres[(minpeak[1]-2):(minpeak[1]+nrow(bat)+1),
      (minpeak[2]-2):(minpeak[2]+ncol(bat)+1)] <- 1 # 白枠を作成
sadres[(minpeak[1]):(minpeak[1]+nrow(bat)-1),
      (minpeak[2]):(minpeak[2]+ncol(bat)-1)] <- bat # 枠に画像をあてはめる
display(sadres)  

ncc <- NCC(board, bat)                       # 正規化相互相関を計算
display(ncc)                                 # 相関の結果を表示
maxpeak <- which(ncc==max(ncc),arr.ind=TRUE) # 最大値を探す
nccres <- board
# 上の座標はパディングされた結果なので元画像上の位置はbatの大きさを引いたもの
nccres[(maxpeak[1]-nrow(bat)-2):(maxpeak[1]+1),
      (maxpeak[2]-ncol(bat)-2):(maxpeak[2]+1)] <- 1
nccres[(maxpeak[1]-nrow(bat)):(maxpeak[1]-1),
      (maxpeak[2]-ncol(bat)):(maxpeak[2]-1)] <- bat
display(nccres)

fncc <- FNCC(board, bat) # 切り出した画像のテンプレートマッチング
display(normalize(fncc)) # 相関の結果を表示
maxpeak <- which(fncc==max(fncc),arr.ind=TRUE)
maxpeak
fnccres <- board
fnccres[(maxpeak[1]-2):(maxpeak[1]+nrow(bat)+1),
       (maxpeak[2]-2):(maxpeak[2]+ncol(bat)+1)] <- 1
fnccres[(maxpeak[1]):(maxpeak[1]+nrow(bat)-1),
       (maxpeak[2]):(maxpeak[2]+ncol(bat)-1)] <- bat
display(fnccres)

