text <- readImage(system.file("images/text.bmp", package="RImageBook"))
textb <- EBI2biOps(text)             # biOps形式に変換
textbedge <- imgPrewitt(textb)       # 水平垂直両方向のPrewittフィルタを適用
plot(textbedge)
 
textedges <- imgSobel(textb)
plot(textedges)
 
textedgem <- imgMarrHildreth(textb, 3)
plot(textedgem)
 
textedgec <- imgCanny(textb, 2)
plot(textedgec)
 
 