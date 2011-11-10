.fft2d <- function(x, inverse=FALSE) {
  t(mvfft(t(mvfft(x, inverse)), inverse))
}