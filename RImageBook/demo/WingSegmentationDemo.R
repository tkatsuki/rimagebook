## Demo for p.189 Fig.12.13
x <- readImage(system.file("images/wildwg.png", package="RImageBook"))
display(x, "Original image")
x <- 1-x
display(x, "Inverted image")
mask <- thresh(x, 5, 5, 0.03)
display(mask, "Binary image")
mask <- bwlabel(mask)
mm <- cmoments(mask, x)
ll <- which(mm[,'m.pxs']<=500)
mask <- rmObjects(mask, ll)
mask <- mask > 0
mask <- closing(mask, makeBrush(5, shape="diamond"))
display(mask, "Denoised image")
ske <- thinning(mask)
display(ske, "Skeleton")
display(normalize(x + ske), "Skeleton over the wing")
prunedske <- pruning(ske)
display(prunedske, "Pruned skeleton")
branch <- branch(prunedske)
display(normalize(branch + prunedske), "Branch points")
branchpos <- which(branch==1, arr.ind=TRUE)
rescoord <- branchpos[order(branchpos[,'row'], decreasing = TRUE),][1:8,]
bg <- ske*0
bg[rescoord] <- 1
bg <- dilate(bg, makeBrush(5, shape="diamond"))
display(normalize(bg + x), "8 branch points on the wing")
wingarea <- normalize(bwlabel(1-ske)) 
display(wingarea, "Segmented wing areas")
