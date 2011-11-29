## Demo for p.105 Fig.7.6
shapes <- readImage(system.file("images/shapes.png", package="EBImage"))
logo <- shapes[110:512,1:130]
logod <- distmap(logo, metric=c('euclidean'))
display(normalize(logod), "Distance map")
logol <- bwlabel(logo)
max(logol)

## Demo for p.107 Fig.7.9
display(normalize(logol), "Labeling")
logolr <- rmObjects(logol, 3)
display(logolr, "3rd object removed")
logol2 <- reenumerate(logolr)
display(normalize(logol2), "Relabeling")
max(logol2)

## Demo for p.108 Fig.7.10
x <- matrix(0, 400, 400)
y <- drawCircle(x, 100, 200, 60, col=1, fill=TRUE)
z <- drawCircle(y, 200, 200, 60, col=1, fill=TRUE)
display(z, "Fused circles")
w <- distmap(z)
wt <- watershed(w)
display(normalize(w), "Distance map")
display(normalize(wt), "Watershed segmentation")

## Demo for p.110 Fig.7.11
gel <- readImage(system.file("images/ima7.gif", package="RImageBook"))
display(gel, "Original image")
display(1-gel, "Inverted image")
gelbw <- thresh(1-gel, w=8, h=8, offset=0.01)
display(gelbw, "Thresholding")
kern <- makeBrush(3, shape="diamond")
gelbwsm <- closing(opening(gelbw, kern), kern)
display(gelbwsm, "Denoised image")
geldist <- distmap(gelbwsm)
display(normalize(geldist), "Distance map")
gelwsh02 <- watershed(geldist, tolerance=0.2)
gelwsh10 <- watershed(geldist, tolerance=1)
gelwsh40 <- watershed(geldist, tolerance=4)
gelresult <- EBImage::combine(normalize(gelwsh02),
                     normalize(gelwsh10),
                     normalize(gelwsh40))
display(gelresult, "Watershed segmentation with different tolerance")

## Demo for p.111 Fig.7.13
x <- matrix(0, 400, 400)
y <- drawCircle(x, 100, 200, 60, col=1, fill=TRUE)
z <- drawCircle(y, 250, 200, 120, col=1, fill=TRUE)
display(z, "Original image")
dm <- distmap(z)
display(normalize(dm), "Distance map")
wsh <- watershed(dm)
display(normalize(wsh), "Watershed segmentation")
peaks <- findPeaks(dm)
display(normalize(peaks), "Peaks")
seg1 <- propagate(z, bwlabel(peaks), z)
display(normalize(seg1), "Segmentaion by Voronoi")
peakval <- dm * peaks
min2 <- sort(unique(as.vector(peakval)))[2] 
seeds <- dm >= min2
seeds <- bwlabel(seeds)
display(normalize(seeds), "New seeds")
seg2 <- propagate(z, seeds, z)
display(normalize(seg2), "Improved segmentation")

## Demo for p.112 Fig.7.14
display(shapes, "Original image")
shapesl <- bwlabel(shapes)
ftrs <- hullFeatures(shapesl)
id <- which(ftrs[, 'g.acirc']<0.05 & ftrs[, 'g.pdm']>2)
shapesl[is.na(match(shapesl, id))] <- 0
display(shapesl, "Obal objects")

## Demo for p.114 Fig.7.15
shapess <- erode(shapes, makeBrush(3, shape="diamond"))
shapese <- shapes - shapess
display(shapese, "Edges")
contour(shapes, nlevels=2, drawlabels=FALSE)
ocontour(shapes)
