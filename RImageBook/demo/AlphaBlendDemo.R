## Demo for p.70 Fig.4.22
girl <- readImage(system.file("images/girl.bmp", package="RImageBook"))
woman <- readImage(system.file("images/WOMAN.bmp", package="RImageBook"))
blend <- array(dim = c(256, 256, 10))
for (i in 1:10){
  blend[,,i] <- (i/10)*girl + (1-i/10)*woman
}
display(blend, "Dissolve")

## Demo for p.70 Fig.4.23
river <- readImage(system.file("images/river.jpg", package="RImageBook"))
pond <- readImage(system.file("images/pond.jpg", package="RImageBook"))
gradlr <- matrix(seq(0, 1, length.out=nrow(river)), nrow(river), ncol(river)) 
gradrl <- 1- gradlr
rivnd <- river * gradlr + pond * gradrl 
display(rivnd, "Alpha blending")
