skeletonize <- function(x){
  s <- matrix(1, nrow(x), ncol(x)) # 白紙を用意
  skel <- matrix(0, nrow(x), ncol(x)) # 黒い背景を用意
  kern <- makeBrush(3, shape="diamond") # 構造要素の作成
  while(max(s)==1){
    k <- opening(x, kern) # オープニング処理
    s <- x-k # 元画像との差分をとる
    skel <- skel | s # 差分の結果を骨格の一部とする
    x <- erode(x, kern) # 収縮処理
  }
  return(skel)
}