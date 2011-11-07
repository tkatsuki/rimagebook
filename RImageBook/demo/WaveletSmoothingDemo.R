library(waveslim)
# ウェーブレット変換によるノイズ除去
cup <- readImage(system.file("images/cupgirl.png", package="RImageBook"))
cupb <- E2b(cup)                         # biOps形式に変換
cupbgn <- imgGaussianNoise(cupb, 0, 120) # ガウシアンノイズを混入させる
cupgn <- b2E(cupbgn)
cupgnwvs <- denoise.modwt.2d(cupgn, wf="d4", rule="soft")
cupgnwvh <- denoise.modwt.2d(cupgn, wf="d4", rule="hard")
display(cupgn)    # 元画像の表示
display(cupgnwvs) # ウェーブレット変換によるノイズ除去後の画像
display(cupgnwvh)