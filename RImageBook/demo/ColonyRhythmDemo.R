## Demo for p.176 Fig.12.6 and p.179 Fig.12.7
## The image data p2 is included only in the full version of RImageBook
## Load images and get dimensions
dir <- system.file("images/p2", package="RImageBook")
filelist <- list.files(dir, pattern=".tiff")
images <- lapply(filelist, function(x) readImage(paste(dir, "/", x, sep="")))
w <- nrow(images[[1]])
h <- ncol(images[[1]])

## Create a mask of colonies
images <- array(unlist(images), c(w, h, length(filelist)))
imagea <- medianPrj(images)
display(normalize(imagea))
mask1 <- thresh(imagea, 10, 10, 0.00003)
display(mask1)
mask2 <- matrix(0, 512, 512)
mask2 <- drawCircle(mask2, 250, 260, 190, col=1, fill=TRUE)
display(mask2)
mask3 <- mask1 * mask2
display(mask3)
mask3 <- bwlabel(mask3)
hf <- hullFeatures(mask3)
id <- which(hf[,'g.s'] < 10 | hf[,'g.s'] > 100 | hf[,'g.acirc'] > 0.1)
mask3 <- rmObjects(mask3, id)
mask3 <- mask3 > 0
mask3 <- bwlabel(mask3)

## Label colonies with numbers
hf <- hullFeatures(mask3)
labels  <- as.character(c(1:max(mask3)))
xy <- hf[,c('g.x','g.y')]
xy <- xy +5
display(drawtext(mask3, xy, labels=labels, col="white"))

## Obtain intensity changes of each colony
mask4 <- array(mask3, dim=c(w, h, dim(images)[3]))
m <- cmoments(mask4, images)

## Plot intensity changes as a function of time
result <- sapply(m, function(x) x[,"m.int"]/x[,"m.pxs"])
result <- t(result)
nresult <- apply(result, 2, function(x) x/min(x))
x <- matrix(c(1:nrow(result))*2, nrow(result), ncol(result))
matplot(x, result, xlab="hours", ylab="A.U.", type="l") 
matplot(x, nresult, xlab="hours", ylab="A.U.", type="l")
matplot(rowMeans(x), rowMeans(result), xlab="hours", ylab="A.U.", type="l") 

## Frequency analysis using wavelet transformation
set.seed(10)
res <- wc((result*2^16)^2, 0.5)            # wavelet transformation

## Plot results
dev.off()
hist(res[,1], xlim=c(20, 30), xlab="period (hr)", ylab="frequency", breaks=30, main="")
matplot(x[,which(res[,1] > 27)], result[,which(res[,1] > 27)], xlab="hours", ylab="A.U.", type="l")
res0 <- replace(res, which(is.na(res)), 0)

## Color code the length of period
for (i in 1:length(res[,1])){
  mask3[which(mask3==i)] <- res0[i,1]
} 
min <- floor(255*sort(unique(as.vector(normalize(mask3))))[2])
mask4 <- pseudoColor2(normalize(mask3), min-1, 255)
display(mask4)
rainbowbar <- rainbowBar(100, 20)
bns <- rotate(rainbowbar, -90) 
minchr <- as.character(round(sort(unique(as.vector(mask3)))[2]))
maxchr <- as.character(round(max(as.vector(mask3)))) 
mask4[(w-30):(w-30+nrow(bns)-1), 20:(20+ncol(bns)-1), 1:3] <- bns
arial <- drawfont(family="arial", size=10)
mask4 <- drawtext(mask4, c(w-45, (25+ncol(bns))), minchr, col="white", font=arial)
mask4 <- drawtext(mask4, c(w-45, 20), maxchr, col="white", font=arial)
display(mask4)
