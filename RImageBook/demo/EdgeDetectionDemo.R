## Demo for p.81 Fig.5.7
text <- readImage(system.file("images/text.bmp", package="RImageBook"))
textb <- E2b(text)
textbedge <- imgPrewitt(textb)
plot(textbedge)
 
textedges <- imgSobel(textb)
plot(textedges)
 
textedgem <- imgMarrHildreth(textb, 3)
plot(textedgem)
 
textedgec <- imgCanny(textb, 2)
plot(textedgec)
