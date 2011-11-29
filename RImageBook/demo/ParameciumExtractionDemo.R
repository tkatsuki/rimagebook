## Demo for p.144 Fig.9.5
para <- readAVI(system.file("images/paramecium.avi", package="RImageBook"))/255
display(para, "Original movie")
paramed <- medianPrj(para)
display(paramed, "Extracted background")
w <- nrow(para[,,1])
h <- ncol(para[,,1])
nf <- getNumberOfFrames(para)
paramed <- array(rep(paramed, nf), dim=c(w, h, nf))
paranobg <- para - paramed
rm(paramed)
display(paranobg, "Background subtraction")
mask <- paranobg[,,] > 0.2
display(mask, "Binary movie")
rm(paranobg)
