library(waveslim)
# ウェーブレット変換によるノイズ除去
cupgnwvs <- denoise.modwt.2d(cupgn, wf="d4", rule="soft")
cupgnwvh <- denoise.modwt.2d(cupgn, wf="d4", rule="hard")
display(cupgn)    # 元画像の表示
display(cupgnwvs) # ウェーブレット変換によるノイズ除去後の画像
display(cupgnwvh)