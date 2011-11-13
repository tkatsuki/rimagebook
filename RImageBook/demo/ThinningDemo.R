shapes <- readImage(system.file("images/shapes.png", package="EBImage"))
logo <- shapes[110:512,1:130]
ske <- skeletonize(logo)
display(ske)
logot <- thinning(logo)
display(logot)
logoends <- ending(logot)
display(dilate(logoends, makeBrush(3)))
logotends <- dilate(logoends, makeBrush(3))*2 + logot
display(normalize(logotends))
length(which(logoends == 1))

logobr <- branch(logot)
display(dilate(logobr, makeBrush(3)))

logotbr <- dilate(logobr, makeBrush(3))*2 + logot
display(normalize(logotbr))
length(which(logobr == 1))
logotp <- pruning(logot, 4)
display(logotp)