cam <- readImage(system.file("images/Cameraman.bmp", package="RImageBook"))
cam <- EBI2biOps(cam)
histogram(cam) # ヒストグラムの表示
cambw <- imgThreshold(cam, 75) # 75を閾値として2値化
plot(cambw)                    # 2値化した画像を表示
camkm <- imgKMeans(cam, 2) # \(k\)-means法による2値化
plot(camkm)
unique(as.vector(camkm))   # クラスタリングの結果を調べる．as.vectorについては付録B.2．

doc <- readImage(system.file("images/scan.JPG", package="RImageBook"))
docbw <- doc > 0.7                # 単純な閾値処理で0.7より大きい画素を白画素に
docbw2 <- thresh(doc, 7, 7, -0.1) # thresh()関数による平均移動法
display(doc); display(docbw); display(docbw2)
docbg <- gblur(doc, 20, 10)       # ガウシアンブラー
docfl <- doc -docbg               # 背景の減算
docflbw <- docfl > 0.001          # 単純な閾値処理
display(docbg); display(docfl)