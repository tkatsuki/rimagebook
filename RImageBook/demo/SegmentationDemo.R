## Demo for p.105 Fig.7.6
logod <- distmap(logo, metric=c('euclidean'))
display(normalize(logod))
logol <- bwlabel(logo)
max(logol)

## Demo for p.107 Fig.7.9
display(normalize(logol))
logolr <- rmObjects(logol, 3)
display(logolr)
logol2 <- reenumerate(logolr)
display(normalize(logol2))
max(logol2)

## Demo for p.108 Fig.7.10
x <- matrix(0, 400, 400)
y <- drawCircle(x, 100, 200, 60, col=1, fill=TRUE)
z <- drawCircle(y, 200, 200, 60, col=1, fill=TRUE)
display(z)
w <- distmap(z)
wt <- watershed(w)
display(normalize(w))
display(normalize(wt))

## Demo for p.110 Fig.7.11
gel <- readImage(system.file("images/ima7.gif", package="RImageBook"))
display(1-gel)
gelbw <- thresh(1-gel, w=8, h=8, offset=0.01)
display(gelbw)
kern <- makeBrush(3, shape="diamond")
gelbwsm <- closing(opening(gelbw, kern), kern)
display(gelbwsm)
geldist <- distmap(gelbwsm)
display(normalize(geldist))
gelwsh02 <- watershed(geldist, tolerance=0.2)
gelwsh10 <- watershed(geldist, tolerance=1)
gelwsh40 <- watershed(geldist, tolerance=4)
gelresult <- combine(normalize(gelwsh02),
                     normalize(gelwsh10),
                     normalize(gelwsh40))
display(gelresult)

## Demo for p.111 Fig.7.13
x <- matrix(0, 400, 400)
y <- drawCircle(x, 100, 200, 60, col=1, fill=TRUE)
z <- drawCircle(y, 250, 200, 120, col=1, fill=TRUE)
display(z, title="original")
dm <- distmap(z)
display(normalize(dm))
wsh <- watershed(dm)
display(normalize(wsh), title="watershed")
peaks <- findPeaks(dm)
display(normalize(peaks), title="peaks")
seg1 <- propagate(z, bwlabel(peaks), z)
display(normalize(seg1), title="segmentaion by peak seeds")
peakval <- dm * peaks
min2 <- sort(unique(as.vector(peakval)))[2] 
seeds <- dm >= min2
seeds <- bwlabel(seeds)
display(normalize(seeds), title="seeds")
seg2 <- propagate(z, seeds, z)
display(normalize(seg2), title="new segmentation")

## Demo for p.112 Fig.7.14
display(shapes)
shapesl <- bwlabel(shapes)
ftrs <- hullFeatures(shapesl)
id <- which(ftrs[, 'g.acirc']<0.05 & ftrs[, 'g.pdm']>2)
shapesl[is.na(match(shapesl, id))] <- 0
display(shapesl)

## Demo for p.114 Fig.7.15
shapess <- erode(shapes, makeBrush(3, shape="diamond"))
shapese <- shapes - shapess
display(shapese)
contour(shapes, nlevels=2, drawlabels=FALSE)
ocontour(shapes)
