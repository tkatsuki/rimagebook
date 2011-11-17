                             # 3次元画像データの読み込み
img <- readImage(system.file("images/muscle.tif", package="RImageBook"))
img <- img@.Data              # ピクセルデータを抜き出す
                              # 16スライスから26スライスまでを3列のタイル表示
imgt <- tile(img[,,c(16:27)], 3)
display(imgt)
display(imgRowMaxs(img))      # 最大値で投射
display(rowSums(img, dim=2))  # 和で投射