## Demo for p.134 Fig.8.9
img <- readImage(system.file("images/muscle.tif", package="RImageBook"))
img <- img@.Data
imgt <- tile(img[,,c(16:27)], 3)
display(imgt)

## Demo for p.134 Fig.8.10
display(img[,,20])
display(imgRowMaxs(img))
display(rowSums(img, dim=2))