## Demo for p.76 Fig.5.3
cup <- readImage(system.file("images/cupgirl.png", package="RImageBook"))
cupb <- E2b(cup)
cupbgn <- imgGaussianNoise(cupb, 0, 120)
cupbsp <- imgSaltPepperNoise(cupb, 5)
cupgn <- b2E(cupbgn)
cupsp <- b2E(cupbsp)
display(cup, "Original image")
display(cupgn, "Gaussian noise")
display(cupsp, "Salt and pepper noise")

## Demo for p.77 Fig.5.4
meanFilter <- matrix(1/9, 3, 3)
cupmean <- filter2(cup, meanFilter)
cupspmean <- filter2(cupsp, meanFilter)
cupgnmean <- filter2(cupgn, meanFilter)
display(cupmean, "Mean filter on the original")
display(cupspmean, "Mean filter on salt and pepper noise")
display(cupgnmean, "Mean filter on Gaussian noise")

gsfilter <- GaussianKernel(3, 3, 2)
cupgauss <- filter2(cup, gsfilter)
cupgngauss <- filter2(cupgn, gsfilter)
cupspgauss <- filter2(cupsp, gsfilter)
display(cupgauss, "Gaussian filter on the original")
display(cupgngauss, "Gaussian filter on Gaussian noise")
display(cupspgauss, "Gaussian filter on salt and pepper noise")

cupbmed <- imgBlockMedianFilter(cupb)
cupbgnmed <- imgBlockMedianFilter(cupbgn)
cupbspmed <- imgBlockMedianFilter(cupbsp)
display(b2E(cupbmed), "Median filter on the original")
display(b2E(cupbgnmed), "Median filter on Gaussian noise")
display(b2E(cupbspmed), "Median filter on salt and pepper noise")

## Demo for p.78
cupgauss <- gblur(cup, 3, 1)
display(cupgauss, "Gaussian blur")

## Demo for p.79
gauss9 <- GaussianKernel(9, 9, 5)
cupgauss9 <- filter2(cup, gauss9)
display(cupgauss9, "9 x 9 Gaussian filter")
