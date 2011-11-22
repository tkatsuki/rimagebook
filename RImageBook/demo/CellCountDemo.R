## Demo for p.173 Fig.12.4 and p.175 Fig.12.5

## Load image and get dimensions
img <- readImage(system.file("images/DAPI.tif", package="RImageBook"))
img <- img@.Data
h <- dim(img)[1]
w <- dim(img)[2]
nf <- dim(img)[3]
display(imgRowMaxs(img))                 # Display a MIP image

## Make a 2D mask
nmask <- thresh(img, 20, 20, 0.01)
display(nmask)
kern <- makeBrush(3, shape="disc")
nmask <- opening(nmask, kern)
nmask <- rowSums(nmask, dims=2)
nmask <- distmap(nmask)
display(normalize(nmask))
nmask <- watershed(nmask, tolerance=0.1) # Watershed based object detection 
display(normalize(nmask))
mm <- cmoments(nmask, nmask)             # Caculate central moments
id <- which(mm[, 'm.pxs'] < 40)          # Select objects smaller than 40 px
nmask <- rmObjects(nmask, id)            # Remove the selected objects
display(normalize(nmask))
nmask <- reenumerate(nmask)              # Re-label objects
max(nmask)                               # Get the number of object

## Make a 3D mask and obtain intensity profiles as a function of frame
nmask <- array(nmask, dim=c(h, w, nf))
mma <- cmoments(nmask, img)
mma2 <- unlist(mma)
result <- array(mma2, dim=c(dim(mma[[1]])[1], dim(mma[[1]])[2], length(mma)))
str(result)

## Plot results in various ways
matplot(t(result[,2,]), type="l")        # Plot all data
averes <- colMeans(result[,2,], dim=1)
plot(averes, type="l", ylab="Intensity") # Plot averaged data
plot(result[9,2,], type="l", ylab="Intensity") # Plot only object 9

## Count the number of peaks
if(!require(msProcess)){
  install.packages("msProcess")
  library("msProcess")
}
                                         # Normalize data
nresult <- apply(result[,2,], 1, function(x) x/max(x))
                                         # Smooth data
nsresult <- apply(nresult, 2, function(x) msSmoothMean(x, 3))
                                         # Count peaks
cellnum <- apply(nsresult, 2, function(x) length(which(x[which(peaks(x, 3)==1)]> 0.2)))
sum(cellnum)

## Plot data that have 0, 1, and 4 peaks
matplot(nsresult[,which(cellnum==0)[1:10]], type="l", ylab="Relative Intensity")
matplot(nsresult[,which(cellnum==1)[1:10]], type="l", ylab="Relative Intensity")
matplot(nsresult[,which(cellnum==4)[1:10]], type="l", ylab="Relative Intensity")

## Label objects on the original image
labels  <- as.character(which(cellnum==4))
xy <- result[which(cellnum==4),c(3,4),]
bgimg <- matrix(0, nrow(img[,,1]), ncol(img[,,1]))
numimg <- drawtext(bgimg, xy, labels=labels, col="white")
conimg <- img+array(rep(numimg, dim(img)[3]), c(h, w, nf))
display(conimg)
