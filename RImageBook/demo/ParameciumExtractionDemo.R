para <- readAVI(system.file("images/paramecium.avi", package="RImageBook"))/255
paramed <- medianPrj(para)
w <- nrow(para[,,1])
h <- ncol(para[,,1])
nf <- getNumberOfFrames(para)
paramed <- array(rep(paramed, nf), dim=c(w, h, nf))
paranobg <- para - paramed
rm(paramed)
display(paranobg)
mask <- paranobg[,,] > 0.2
display(mask)
rm(paranobg)
