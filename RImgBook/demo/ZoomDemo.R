a <- readImage(system.file("images/woman.png", package="RImageBook"))
display(a)
eye <- a[200:249, 310:359]
ab <- a
ab[199:250, 309:360] <- 1
ab[200:249, 310:359] <- eye
display(ab)
eyenn <- resize(eye, 500, filter="box")
display(eyenn)
eyebl <- resize(eye, 500, filter="Triangle")
display(eyebl)
eyelz <- resize(eye, 500, filter="Lanczos")
display(eyelz)
eyecb <- resize(eye, 500, filter="Cubic")
display(eyecb)
eyesp <- imgScale(EBI2biOps(eye), 10, 10, "spline")
display(biOps2EBI(eyesp))
