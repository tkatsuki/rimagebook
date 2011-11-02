blend <- array(dim = c(256, 256, 10)) # 画像を格納する配列を用意
for (i in 1:10){              # マルチページの画像としてブレンド画像を作成する
  blend[,,i] <- (i/10)*girl + (1-i/10)*woman
}
display(blend)

river <- readImage(system.file("images/river.jpg", package="RImageBook"))
pond <- readImage(system.file("images/pond.jpg", package="RImageBook"))
# 8 ビットグレースケールのグラデーションを作成する
gradlr <- matrix(seq(0, 1, length.out=nrow(river)), nrow(river), ncol(river)) 
gradrl <- 1- gradlr
rivnd <- river * gradlr + pond * gradrl 
display(rivnd)