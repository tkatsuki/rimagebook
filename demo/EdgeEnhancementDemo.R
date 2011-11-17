cassini <- readImage(system.file("images/cassini.jpg", package="RImageBook"))
                                  # 4近傍のラプラシアンフィルタを作成する
lap4 <- matrix(c(0, 1, 0, 1, -4, 1, 0, 1, 0), 3, 3, byrow=TRUE)
caslap4 <- filter2(cassini, lap4) # ラプラシアンフィルタを適用
display(cassini)                  #　鮮鋭化前の画像
display(cassini - 0.5*caslap4)    #　鮮鋭化
display(cassini - 0.8*caslap4)    # より強い鮮鋭化
display(cassini - caslap4)　       # さらに強い鮮鋭化