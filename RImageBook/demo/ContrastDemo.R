tulip <- readImage(system.file("images/tulip.jpg", package="RImageBook"))
histogram(tulip)

tulip <- tulip@.Data
tulipce <- ifelse(tulip > 0.8, 1, tulip/0.8)
display(tulipce)
tulipcee <- ifelse(tulip > 0.8, 1, (tulip + 0.2)/(0.8 + 0.2))
display(tulipcee)

tulipcee <- ifelse(tulip 0.8, 1, (tulip + 0.2)/(0.8 + 0.2))
display(tulipcee)

tulipcd <- 0.5*tulip+0.2
display(tulipcd)

tulipnorm <- normalize(tulip)
display(tulipnorm)

tulipgm05 <- tulip^(1/0.5)
tulipgm20 <- tulip^(1/2.0)
display(tulipgm05)
display(tulipgm20)

tulips <- (1/(1+(0.5/tulip)^5))
display(tulips)

tulip10 <- tulip * 10
display(tulip10)
tuliplog <- (log1p(tulip10)/log1p(max(tulip10)))
display(tuliplog)

cath <- readImage(system.file("images/cathedral.jpg", package="RImageBook"))
catheq <- equalize(cath)
display(catheq)

hand <- readImage(system.file("images/hand.jpg", package="RImageBook"))
handinv <- 1-hand

f <- system.file("images/lighthouse.jpg", package="RImageBook")
lighthouse <- readImage(f)
display(lighthouse)
lighthousesol <- -4*(lighthouse-0.5)^2+1
display(lighthousesol)
lighthousesol2 <- 0.5*sin(3*pi*lighthouse-pi/2)+0.5
display(lighthousesol2)

parrot <- readImage(system.file("images/parrots.png", package="RImageBook"))
display(parrot)
parrotp <- replace(parrot, which(0<parrot & parrot<=0.25), 0)
parrotp <- replace(parrotp, which(0.25<parrotp & parrotp<=0.5), 0.25)
parrotp <- replace(parrotp, which(0.5<parrotp & parrotp<=0.75), 0.5)
parrotp <- replace(parrotp, which(0.75<parrotp & parrotp<=1), 0.75)
display(parrotp)

parrotb <- E2b(parrot)
parrotk <- imgKMeans(parrotb, 4)
parrotk <- b2E(parrotk)
display(parrotk)