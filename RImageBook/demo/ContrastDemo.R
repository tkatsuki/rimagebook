## Demo for p.54 Fig.4.9
tulip <- readImage(system.file("images/tulip.jpg", package="RImageBook"))
display(tulip)
histogram(tulip)

## Demo for p.57 Fig.4.11
tulip <- tulip@.Data
tulipce <- ifelse(tulip > 0.8, 1, tulip/0.8)
display(tulipce)
histogram(tulipce)
tulipcee <- ifelse(tulip > 0.8, 1, (tulip + 0.2)/(0.8 + 0.2))
display(tulipcee)
histogram(tulipcee)

## Demo for p.58 Fig.4.12
tulipcd <- 0.5*tulip+0.2
display(tulipcd)
histogram(tulipcd)

## Demo for p.59 Fig.4.13
tulipnorm <- normalize(tulip)
display(tulipnorm)
histogram(tulipnorm)

## Demo for p.60 Fig.4.14
tulipgm05 <- tulip^(1/0.5)
tulipgm20 <- tulip^(1/2.0)
display(tulipgm05)
display(tulipgm20)
histogram(tulipgm05)
histogram(tulipgm20)

## Demo for p.61 Fig.4.15
tulips <- (1/(1+(0.5/tulip)^5))
display(tulips)
histogram(tulips)

## Demo for p.62 Fig.4.16
tulip10 <- tulip * 10
display(tulip10)
histogram(tulip10)
tuliplog <- (log1p(tulip10)/log1p(max(tulip10)))
display(tuliplog)
histogram(tuliplog)

## Demo for p.63 Fig.4.17
cath <- readImage(system.file("images/cathedral.jpg", package="RImageBook"))
display(cath)
histogram(cath)
catheq <- equalize(cath)
display(catheq)
histogram(catheq)

## Demo for p.64 Fig.4.18
hand <- readImage(system.file("images/hand.jpg", package="RImageBook"))
display(hand)
histogram(hand)
handinv <- 1-hand
display(handinv)
histogram(handinv)

## Demo for p.65 Fig.4.19
f <- system.file("images/lighthouse.jpg", package="RImageBook")
lighthouse <- readImage(f)
display(lighthouse)
histogram(lighthouse)
lighthousesol <- -4*(lighthouse-0.5)^2+1
display(lighthousesol)
histogram(lighthousesol)
lighthousesol2 <- 0.5*sin(3*pi*lighthouse-pi/2)+0.5
display(lighthousesol2)
histogram(lighthousesol2)

## Demo for p.66 Fig.4.20
parrot <- readImage(system.file("images/parrots.png", package="RImageBook"))
display(parrot)
histogram(parrot)
parrotp <- replace(parrot, which(0<parrot & parrot<=0.25), 0)
parrotp <- replace(parrotp, which(0.25<parrotp & parrotp<=0.5), 0.25)
parrotp <- replace(parrotp, which(0.5<parrotp & parrotp<=0.75), 0.5)
parrotp <- replace(parrotp, which(0.75<parrotp & parrotp<=1), 0.75)
display(parrotp)
histogram(parrotp)
parrotb <- E2b(parrot)
parrotk <- imgKMeans(parrotb, 4)
parrotk <- b2E(parrotk)
display(parrotk)
histogram(parrotk)