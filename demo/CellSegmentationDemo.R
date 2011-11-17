                                   # 細胞の画像を読み込む
cell <- readImage(system.file("images/cells.tif", package="EBImage"))
cell <- cell[,,1]                  # 1フレーム目だけを抽出
display(cell)                      # 細胞の画像を表示
cmask <- cell > 0.1                # 単純な閾値処理で2値化
kern <- makeBrush(5, shape="disc") # モルフォロジー演算のための構造要素を作成
cmask <- closing(opening(cmask, kern), kern) # モルフォロジー演算でノイズを除去
                                   # 核の画像を読み込む
nuc <- readImage(system.file("images/nuclei.tif", package="EBImage"))
nuc <- nuc[,,1]                    # 1フレーム目だけを使う
nmask <- thresh(nuc, 10, 10, 0.05) # 画像を2値化
nmask <- opening(nmask, kern)      # オープニング処理でノイズを除去
nmask <- bwlabel(nmask)            # ラベリング処理
display(normalize(nmask))          # ラベルリングの結果を表示
                                   # ボロノイ分割
cmask <- propagate(cell, nmask, cmask, lambda=1e-2)
display(normalize(cmask))          # 分割の結果を表示
img  <- rgbImage(green=1.5*cell, blue=nuc)       # 疑似カラー画像の作成
res <- paintObjects(cmask, img, col= "#ff00ff")  # 細胞の縁取り
xy <- hullFeatures(cmask)[, c('g.x', 'g.y')]     # 細胞の座標を取得
labels <- as.character(1:nrow(xy))               # 細胞の番号を文字列に変換
font <- drawfont(weight=600,  size=16)           # 描画するフォントを指定
                                                 # ラベルを描く
res <- drawtext(res, xy=xy, labels=labels, font=font, col="white")
display(res)                                     # 結果を表示