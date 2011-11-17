x <- readImage(system.file("images/wildwg.png", package="RImageBook"))
x <- 1-x                       # 画像の反転
mask <- thresh(x, 5, 5, 0.03) # 閾値処理で2値化
mask <- bwlabel(mask)          # ラベル化
mm <- cmoments(mask, x)        # オブジェクトのモーメントを求める
ll <- which(mm[,'m.pxs']<=500) # 面積が500ピクセル以下のラベルを選択
mask <- rmObjects(mask, ll)    # 上記のオブジェクトを消去
mask <- mask > 0               # 再度2値化
mask <- closing(mask, makeBrush(5, shape="diamond")) # 穴をふさぐ
display(mask)
ske <- thinning(mask)       # 細線化
display(ske)
display(normalize(x + ske)) # 元画像と細線化後の画像を重ね合わせてチェック
prunedske <- pruning(ske)   # 細線からひげの除去を行う
display(prunedske)
branch <- branch(prunedske)                 # 分岐点の検出
display(normalize(branch + prunedske))
branchpos <- which(branch==1, arr.ind=TRUE) # 分岐点の座標を抽出
                                            # 結果をrowで降順にソートし上位8個を得る
rescoord <- branchpos[order(branchpos[,'row'], decreasing = TRUE),][1:8,]
bg <- ske*0                                 # 背景画像を作る
bg[rescoord] <- 1                           # 抽出した分岐点の座標を1にする
                                            # 見やすくするために点を膨張させる
bg <- dilate(bg, makeBrush(5, shape="diamond"))
display(normalize(bg + x))                  # 分岐点と元画像を重ねて表示
# 細線を反転してラベル化することにより翅の領域化を行う
wingarea <- normalize(bwlabel(1-ske)) 
display(wingarea)