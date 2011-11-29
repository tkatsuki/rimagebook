## Demo for p.97 Fig.6.10
## Requires waveslim package
if(!require(waveslim)){
  install.packages("waveslim")
  library("waveslim")
}
cup <- readImage(system.file("images/cupgirl.png", package="RImageBook"))
cupb <- E2b(cup)
cupbgn <- imgGaussianNoise(cupb, 0, 120)
cupgn <- b2E(cupbgn)
cupgnwvs <- denoise.modwt.2d(cupgn, wf="d4", rule="soft")
cupgnwvh <- denoise.modwt.2d(cupgn, wf="d4", rule="hard")
display(cupgn, "Original image with Gaussian noise")
display(cupgnwvs, "Wavelet denoising, soft setting")
display(cupgnwvh, "Wavelet denoising, hard setting")
