board <- readImage(system.file("images/board.jpg", package="RImageBook"))
display(board)
bat <- board[155:215, 250:315] # 画像切り出し
display(bat)
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
