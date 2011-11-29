## Demo for p.36 Fig.3.12
a <- readImage(system.file("images/woman.png", package="RImageBook"))
display(a, "Original image")
eye <- a[200:249, 310:359]
ab <- a
ab[199:250, 309:360] <- 1
ab[200:249, 310:359] <- eye
display(ab, "Eye position")
eyenn <- resize(eye, 500, filter="box")
display(eyenn, "Nearest neighbour interpolation")
eyebl <- resize(eye, 500, filter="Triangle")
display(eyebl, "bilinear interpolation")
eyelz <- resize(eye, 500, filter="Lanczos")
display(eyelz, "Lanczos interpolation")
eyecb <- resize(eye, 500, filter="Cubic")
display(eyecb, "Bicubic interpolation")
eyesp <- imgScale(EBI2biOps(eye), 10, 10, "spline")
display(biOps2EBI(eyesp), "Bicubic spline interpolation")
