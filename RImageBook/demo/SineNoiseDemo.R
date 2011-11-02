x <- 0:65535
mat <- matrix(0.3*sin(x*pi/50)+0.7, 256, 256)
display(mat)
img <- readImage("../image/mono/lena.bmp")
display(normalize(img * mat))
d <- img * mat
writeImage(d, "../doc/figures/sinelena.eps")
db <- EBI2biOps(d)
df <- imgFFT(db)
dfs <- imgFFTSpectrum(df)
plot(dfs)
dfse <- biOps2EBI(dfs)
writeImage(dfse, "../doc/figures/sinelenaspec.eps")
display(dfse)
display(thresh(dfse, 40, 40, 0.05))
dfseth <- thresh(dfse, 40, 40, 0.05)
kern <- makeBrush(7, "disc")
mask <- opening(dfseth, kern)
mask <- closing(opening(dfseth, kern), kern)
mask <- drawCircle(mask, nrow(mask)/2, ncol(mask)/2, 30, col=0, fill=T)
display(mask)
writeImage(mask, "../doc/figures/sinelenamask.eps")
c <- EBI2biOps(1-mask)
dfc <- df * c
spec <- imgFFTSpectrum(dfc)
plot(spec)
display(biOps2EBI(spec))
writeImage(biOps2EBI(spec), "../doc/figures/sinelenafilspec.eps")
nonhalftone <- imgFFTInv(dfc)
display(normalize(biOps2EBI(nonhalftone)))
writeImage(normalize(biOps2EBI(nonhalftone)), "../doc/figures/sinelenares.eps")



