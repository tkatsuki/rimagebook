## Demo for p.189 Fig.12.13
x <- readImage(system.file("images/wildwg.png", package="RImageBook"))
x <- 1-x
mask <- thresh(x, 5, 5, 0.03)
mask <- bwlabel(mask)
mm <- cmoments(mask, x)
ll <- which(mm[,'m.pxs']<=500)
mask <- rmObjects(mask, ll)
mask <- mask > 0
mask <- closing(mask, makeBrush(5, shape="diamond"))
display(mask)
ske <- thinning(mask)
display(ske)
display(normalize(x + ske))
prunedske <- pruning(ske)
display(prunedske)
branch <- branch(prunedske)
display(normalize(branch + prunedske))
branchpos <- which(branch==1, arr.ind=TRUE)
rescoord <- branchpos[order(branchpos[,'row'], decreasing = TRUE),][1:8,]
bg <- ske*0
bg[rescoord] <- 1
bg <- dilate(bg, makeBrush(5, shape="diamond"))
display(normalize(bg + x))
wingarea <- normalize(bwlabel(1-ske)) 
display(wingarea)
