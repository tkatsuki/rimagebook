## Demo for p.92 Fig.6.3
x <- 0:65535
mat <- matrix(0.3*sin(x*pi/50)+0.7, 256, 256)
display(mat, "Noise")
img <- readImage(system.file("images/lena.bmp", package="RImageBook"))
display(normalize(img * mat), "Noisy Lena")
d <- img * mat
db <- E2b(d)
df <- imgFFT(db)
dfs <- imgFFTSpectrum(df)
dfse <- b2E(dfs)
display(dfse, "FFT spectrum of noisy Lena")
dfseth <- thresh(dfse, 40, 40, 0.05)
kern <- makeBrush(7, "disc")
mask <- opening(dfseth, kern)
mask <- closing(opening(dfseth, kern), kern)
mask <- drawCircle(mask, nrow(mask)/2, ncol(mask)/2, 30, col=0, fill=T)
display(mask)
c <- E2b(1-mask)
dfc <- df * c
spec <- imgFFTSpectrum(dfc)
display(b2E(spec), "Masked spectrum")
nonhalftone <- imgFFTInv(dfc)
display(normalize(b2E(nonhalftone)), "Denoised image")
