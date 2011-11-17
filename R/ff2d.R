.fft2d <- function(x,inverse=FALSE) { # 二次元FFT
 t(mvfft(t(mvfft(x,inverse)),inverse))
}