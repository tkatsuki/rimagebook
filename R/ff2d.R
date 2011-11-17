.fft2d <- function(x,inverse=FALSE) { # “ñŽŸŒ³FFT
 t(mvfft(t(mvfft(x,inverse)),inverse))
}