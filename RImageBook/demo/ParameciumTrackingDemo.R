## Demo for p.181 Fig.12.8 and p.182 Fig.12.9

## Segmentation of Paramecium
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
rm(paranobg)
kern <- makeBrush(5, shape="diamond")
mask <- closing(mask, kern)
mask <- bwlabel(mask)
display(mask, "Binary movie")
rm(para)

# Track objects
track <- tracking(mask)
str(track)

# Display trajectories
display(track[[1]], "Trajectories")

# Plot speed of object 6
plot(track[[2]][which(track[[2]][,1]==6),'speed'], type="l", xlab="frame", ylab="um/sec")

# Calculate total traveled distance
totaldist <- sum(track[[2]][,'distance'], na.rm=TRUE)
totaldist

# Plot average speed of all objects
ave <- rowMeans(matrix(track[[2]][,'speed'], nf), na.rm=TRUE)
plot(ave, type="l", xlab="frame", ylab="um/sec")

# Plot velocity of object 6
pos <- track[[2]][which(track[[2]][,1]==6), c(2,3)]
vel <- track[[2]][which(track[[2]][,1]==6), c(8,9)]
plot(pos)
arrows(pos[,1], pos[,2], pos[,1]+vel[,1]/50, pos[,2]+vel[,2]/50, length = 0.1)
