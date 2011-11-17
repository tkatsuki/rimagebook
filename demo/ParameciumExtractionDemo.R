
# AVIファイルの読み込み
para <- readAVI(system.file("images/paramecium.avi", package="RImageBook"))/255
paramed <- medianPrj(para) # 中央値で時間軸方向に投影する（背景画像となる）
w <- nrow(para[,,1])               # 動画の幅を測る
h <- ncol(para[,,1])               # 動画の高さを測る
nf <- getNumberOfFrames(para)      # 動画のフレーム数を測る
# 背景画像を動画像と同じサイズの配列にする
paramed <- array(rep(paramed, nf), dim=c(w, h, nf))
paranobg <- para - paramed         # 動画像から背景画像を引く
rm(paramed)                        # 不要になったオブジェクトを削除
display(paranobg)
mask <- paranobg[,,] > 0.2         # 閾値処理による2値化
display(mask)
rm(paranobg)
