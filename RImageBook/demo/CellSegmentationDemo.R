## Demo for p.170 Fig.12.1

## Create a cell mask
cell <- readImage(system.file("images/cells.tif", package="EBImage"))
cell <- cell[,,1]
display(cell) 
cmask <- cell > 0.1
kern <- makeBrush(5, shape="disc")
cmask <- closing(opening(cmask, kern), kern)

## Create a nuclear mask
nuc <- readImage(system.file("images/nuclei.tif", package="EBImage"))
nuc <- nuc[,,1]
nmask <- thresh(nuc, 10, 10, 0.05)
nmask <- opening(nmask, kern)
nmask <- bwlabel(nmask)
display(normalize(nmask))

## Segmentation of cell mask using Voronoi diagram
cmask <- propagate(cell, nmask, cmask, lambda=1e-2)
display(normalize(cmask))

## Paint and label objects with color and number
img  <- rgbImage(green=1.5*cell, blue=nuc)
res <- paintObjects(cmask, img, col= "#ff00ff")
xy <- hullFeatures(cmask)[, c('g.x', 'g.y')]
labels <- as.character(1:nrow(xy))
font <- drawfont(weight=600,  size=16)
res <- drawtext(res, xy=xy, labels=labels, font=font, col="white")
display(res)
