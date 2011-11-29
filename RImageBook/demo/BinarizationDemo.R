## Demo for p.100 Fig.7.1
cam <- readImage(system.file("images/Cameraman.bmp", package="RImageBook"))
cam <- E2b(cam)
histogram(cam)
cambw <- imgThreshold(cam, 75)
plot(cambw)
camkm <- imgKMeans(cam, 2)
plot(camkm)
unique(as.vector(camkm))

## Demo for p.101 Fig.7.2
doc <- readImage(system.file("images/scan.JPG", package="RImageBook"))
docbw <- doc > 0.7 
docbw2 <- thresh(doc, 7, 7, -0.1)
display(doc, "Original image")
display(docbw, "Simple thresholding")
display(docbw2, "Local thresholding")
docbg <- gblur(doc, 20, 10) 
docfl <- doc -docbg
docflbw <- docfl > 0.001
display(docbg, "Blurred image")
display(docfl, "Flat fielding")
display(docflbw, "Simple thresholding after flat fielding")
