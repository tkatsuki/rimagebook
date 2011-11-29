## Demo for p.115 Fig.7.16
shapes <- readImage(system.file("images/shapes.png", package="EBImage"))
logo <- shapes[110:512,1:130]
display(logo, "Original image")
ske <- skeletonize(logo)
display(ske, "Skeletonization")

## Demo for p.117 Fig.7.19
logot <- thinning(logo)
display(logot, "Thinning")

## Demo for p.118 Fig.7.20
logoends <- ending(logot)
logotends <- dilate(logoends, makeBrush(3))*2 + logot
display(normalize(logotends), "End points")
length(which(logoends == 1))

## Demo for p.118 Fig.7.21
logobr <- branch(logot)
logotbr <- dilate(logobr, makeBrush(3))*2 + logot
display(normalize(logotbr), "Branch points")
length(which(logobr == 1))

## Demo for p.120 Fig.7.23
logotp <- pruning(logot, 4)
display(logot, "Before pruning")
display(logotp, "After pruning")
