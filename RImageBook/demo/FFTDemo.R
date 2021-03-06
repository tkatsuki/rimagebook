## Demo for p.90 Fig.6.1
w <- matrix(c(0, 0, 0, 0.8), 128, 128)
h <- matrix(c(0, 0, 0, 0, 0, 0, 0, 0.8), 128, 128)
h <- t(h)
display(w)
display(h)
wbfft <- imgFFT(E2b(w))
hbfft <- imgFFT(E2b(h))
wbspec <- imgFFTSpectrum(wbfft)
hbspec <- imgFFTSpectrum(hbfft)
display(b2E(wbspec), "FFT spectrum of w")
display(b2E(hbspec), "FFT spectrum of h")

## Demo for p.91 Fig.6.2
houses <- readImage(system.file("images/houses.png", package="RImageBook"))
display(houses, "Original image")
housesb <- E2b(houses)
housesbfft <- imgFFT(housesb)
str(housesbfft)
housesbffti <- imgFFTInv(housesbfft)
display(b2E(housesbffti), "Inverse FFT")
housesbspec <- imgFFTSpectrum(housesbfft)
display(b2E(housesbspec), "FFT spectrum")
meanFilter <- matrix(1/25, 5, 5)
housesm <- filter2(houses, meanFilter)
gaussFilter <- GaussianKernel(11, 11, 1.8)
housesg <- filter2(houses, gaussFilter)
housesmbf <- imgFFT(E2b(housesm))
housesgbf <- imgFFT(E2b(housesg))
housesmbfspec <- imgFFTSpectrum(housesmbf)
housesgbfspec <- imgFFTSpectrum(housesgbf)
display(b2E(housesmbfspec), "FFT spectrum of mean-filtered image")
display(b2E(housesgbfspec), "FFT spectrum of gaussian-filtered image")

## Demo for p.94 Fig.6.6
houseslpf <- imgFFTLowPass(housesbfft, 50)
houseslps <- imgFFTSpectrum(houseslpf)
houseslp <- imgFFTInv(houseslpf)
display(b2E(houseslps), "FFT spectrum of low pass filtering")
display(b2E(houseslp), "Low pass filtering")

## Demo for p.94 Fig.6.7
houseshpf <- imgFFTHighPass(housesbfft, 20)
houseshps <- imgFFTSpectrum(houseshpf)
houseshp <- imgFFTInv(houseshpf) 
display(b2E(houseshps), "FFT spectrum of high pass filtering")
display(b2E(houseshp), "High pass filtering")

## Demo for p.95 Fig.6.8
housesbpf <- imgFFTBandPass(housesbfft, 20, 100)
housesbps <- imgFFTSpectrum(housesbpf)
housesbp <- imgFFTInv(housesbpf)
display(b2E(housesbps), "FFT spectrum of band pass filtering")
display(b2E(housesbp), "Band pass filtering")

## Demo for p.96 Fig.6.9
w <- nrow(housesb)
h <- ncol(housesb)
gk <- GaussianKernel(w, h, 50)
housesglf <- housesbfft * (gk/max(gk))
housesghf <- housesbfft * (1 - gk/max(gk))
housesgls <- imgFFTSpectrum(housesglf)
housesghs <- imgFFTSpectrum(housesghf)
housesgl <- imgFFTInv(housesglf)
housesgh <- imgFFTInv(housesghf)
display(normalize(t(gk)), "Gaussian low pass filter")
display(normalize(t(1-gk)), "Gaussian high pass filter")
display(b2E(housesgls), "FFT spectrum of Gaussian low pass filtering")
display(b2E(housesghs), "FFT spectrum of Gaussian high pass filtering")
display(b2E(housesgl), "Gaussian low pass filtering")
display(b2E(housesgh), "Gaussian high pass filtering")