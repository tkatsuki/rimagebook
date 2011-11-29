## Demo for p.134 Fig.8.9
img <- readImage(system.file("images/muscle.tif", package="RImageBook"))
display(img, "Original data")
img <- img@.Data
imgt <- tile(img[,,c(16:27)], 3)
display(imgt, "Tiled image")

## Demo for p.134 Fig.8.10
display(img[,,20], "20th slice")
display(imgRowMaxs(img), "MIP")
display(rowSums(img, dim=2), "Sum")
