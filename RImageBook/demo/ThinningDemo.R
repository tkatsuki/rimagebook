## Demo for p.115 Fig.7.16
shapes <- readImage(system.file("images/shapes.png", package="EBImage"))
logo <- shapes[110:512,1:130]
display(logo)
ske <- skeletonize(logo)
display(ske)

## Demo for p.117 Fig.7.19
logot <- thinning(logo)
display(logot)

## Demo for p.118 Fig.7.20
logoends <- ending(logot)
display(dilate(logoends, makeBrush(3)))
logotends <- dilate(logoends, makeBrush(3))*2 + logot
display(normalize(logotends))
length(which(logoends == 1))

## Demo for p.118 Fig.7.21
logobr <- branch(logot)
display(dilate(logobr, makeBrush(3)))
logotbr <- dilate(logobr, makeBrush(3))*2 + logot
display(normalize(logotbr))
length(which(logobr == 1))

## Demo for p.120 Fig.7.23
logotp <- pruning(logot, 4)
display(logotp)
