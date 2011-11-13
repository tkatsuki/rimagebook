img <- readImage(system.file("images/muscle.tif", package="RImageBook"))
img <- img@.Data
imgt <- tile(img[,,c(16:27)], 3)
display(imgt)
display(imgRowMaxs(img))
display(rowSums(img, dim=2))