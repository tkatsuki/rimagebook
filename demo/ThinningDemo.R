shapes <- readImage(system.file("images/shapes.png", package="EBImage"))
logo <- shapes[110:512,1:130]                # ロゴ部分の切り出し
ske <- skeletonize(logo)
display(ske)
logot <- thinning(logo)
display(logot)
logoends <- ending(logot)                             # 端点の検出
display(dilate(logoends, makeBrush(3)))               # 点を強調して表示
logotends <- dilate(logoends, makeBrush(3))*2 + logot # 細線と重ね合わせ
display(normalize(logotends))
length(which(logoends == 1))                          # 端点の個数を数える

logobr <- branch(logot)                      # 分岐点の検出
display(dilate(logobr, makeBrush(3)))        # 点を強調して表示
                                             # 細線と重ね合わせ
logotbr <- dilate(logobr, makeBrush(3))*2 + logot
display(normalize(logotbr))
length(which(logobr == 1))                   # 分岐点の個数を数える
logotp <- pruning(logot, 4) # ひげの剪定
display(logotp)