EBI2biOps <- function(img){
  img <- img*255  # 各色要素を255倍
  img <- imagedata(img)  # 行列をbiOpsの画像データ形式として読み込み
  img <- imgRotate90Clockwise(imgVerticalMirroring(img))  # 転置
  return(img)
}
