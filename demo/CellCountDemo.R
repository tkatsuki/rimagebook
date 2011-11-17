img <- readImage(system.file("images/DAPI.tif", package="RImageBook"))
img <- img@.Data                    # ピクセルデータのみを取り出す
display(imgRowMaxs(img))            # MIP画像の表示
nmask <- thresh(img, 20, 20, 0.01) # 移動平均法による2値化
display(nmask)                     # マスクの表示
kern <- makeBrush(3, shape="disc") # モルフォロジー演算のための構造要素を作成
nmask <- opening(nmask, kern)      # オープニング処理でノイズを除去
nmask <- rowSums(nmask, dims=2)    # すべてのスライスのマスクを投射
nmask <- distmap(nmask)            # 距離地図を作成
display(normalize(nmask))          # 距離地図を表示
nmask <- watershed(nmask, tolerance=0.1) #watershedで分割
display(normalize(nmask))          # 分割後の画像を表示
mm <- cmoments(nmask, nmask)    # オブジェクトのモーメントを計算
id <- which(mm[, 'm.pxs'] < 40) # サイズが40ピクセル以下のオブジェクト
nmask <- rmObjects(nmask, id)   # 上記オブジェクトはノイズとして削除
display(normalize(nmask))       # ノイズ除去後のマスクを表示
nmask <- reenumerate(nmask)     # ラベルを振り直す
max(nmask)

                            # 2次元のマスターマスクを3次元にする
nmask <- array(nmask, dim=c(dim(img)[1], dim(img)[2], dim(img)[3]))
mma <- cmoments(nmask, img) # マスターマスクを使って元の画像からモーメントを計算
mma2 <- unlist(mma)         # リストをベクトルに直す
                            # ベクトルを配列に直す
result <- array(mma2, dim=c(dim(mma[[1]])[1], dim(mma[[1]])[2], length(mma)))
str(result)                 # 結果は3次元の配列となる

matplot(t(result[,2,]), type="l")         # 全オブジェクトの輝度値をプロット
averes <- colMeans(result[,2,], dim=1)    # 全オブジェクトの平均を算出
plot(averes, type="l", ylab="Intensity")  # 全オブジェクトの平均をグラフ表示
plot(result[9,2,], type="l", ylab="Intensity") # 9番目のオブジェクトをプロット
                   # データを正規化
nresult <- apply(result[,2,], 1, function(x) x/max(x))
library(msProcess) # ピーク検出のためのパッケージを読み込む
                   # データの平滑化を行う
nsresult <- apply(nresult, 2, function(x) msSmoothMean(x, 3))
                   # ピークを検出
cellnum <- apply(nsresult, 2, function(x) 
                 length(which(x[which(peaks(x, 3)==1)]> 0.2)))
sum(cellnum)       # ピークの合計

# ピークが0個のデータのうち1から10番目のデータ
matplot(nsresult[,which(cellnum==0)[1:10]], type="l", ylab="Relative Intensity")
# ピークが1個のデータのうち1から10番目のデータ．グラフは省略．
matplot(nsresult[,which(cellnum==1)[1:10]], type="l", ylab="Relative Intensity")
# ピークが4個のデータのうち1から10番目のデータ
matplot(nsresult[,which(cellnum==4)[1:10]], type="l", ylab="Relative Intensity")
labels  <- as.character(which(cellnum==4)) # オブジェクト番号を文字に変換
xy <- result[which(cellnum==4),c(3,4),]    # 同オブジェクトのxy座標
                                           # 黒い背景画像を用意
bgimg <- matrix(0, nrow(img[,,1]), ncol(img[,,1]))
                                           # オブジェクト番号を表示
numimg <- drawtext(bgimg, xy, labels=labels, col="white")
                                           # 元画像にオブジェクト番号を重ねる
conimg <- img+array(rep(numimg, dim(img)[3]), c(dim(img)[1], dim(img)[2], 
                    dim(img)[3]))
display(conimg)                            # 結果の表示