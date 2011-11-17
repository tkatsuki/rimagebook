shapes <- readImage(system.file("images/shapes.png", package="EBImage"))
logo <- shapes[110:512,1:130]                # ロゴ部分の切り出し
display(logo)
logob <- EBI2biOps(logo)                     # biOps形式に変換
logobn <- imgSaltPepperNoise(logob, 5)       # 画像にノイズを追加
logon <- biOps2EBI(logobn)                   # EBImage形式に変換
kern <- makeBrush(3, shape='diamond')        # 構造要素の作成
display(erode(logon, kern))                  # 膨張
display(dilate(logon, kern))                 # 収縮
display(opening(logon, kern))                # オープニング
display(closing(logon, kern))                # クロージング
display(closing(opening(logon, kern), kern)) # オープニング後クロージング
display(opening(closing(logon, kern), kern)) # クロージング後オープニング
