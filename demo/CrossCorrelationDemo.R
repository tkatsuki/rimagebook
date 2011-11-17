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
display(sadres)   # 検出された位置を白枠で表示

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