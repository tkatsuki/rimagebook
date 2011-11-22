skew <- function(x, theta_x=0, theta_y=0){
  if(!require(bitops)){
    install.packages("bitops")
    library("bitops")
  }
  if(!require(RNiftyReg)){
    install.packages("RNiftyReg")
    library("RNiftyReg")
  }
  if(!require(oro.nifti)){
    install.packages("oro.nifti")
    library("oro.nifti")
  }
  if(length(dim(x)) == 2) {
  padx <- tan(theta_y*pi/180)*ncol(x)
  pady <- tan(theta_x*pi/180)*nrow(x)
  if (padx >= 0){
    x <- rbind(matrix(0, padx, ncol(x)), x)
    if (pady >= 0){
      x <- cbind(matrix(0, nrow(x), pady), x)
      } else{
        x <- cbind(x, matrix(0, nrow(x), abs(pady)))
        }
  } else {
    x <- rbind(x, matrix(0, abs(padx), ncol(x)))
    if (pady >= 0){
      x <- cbind(matrix(0, nrow(x), pady), x)
    } else{
      x <- cbind(x, matrix(0, nrow(x), abs(pady)))
    }
  }
  xn <- as.nifti(x)
  aff <- matrix(c(1,tan(theta_y*pi/180),0,0,tan(theta_x*pi/180),
                  1,0,0,0,0,1,0,0,0,0,1), 
                4, 4, byrow=TRUE)
  xreg <- applyAffine(aff, xn, xn, "niftyreg")
  xreg$image
  }else{
    r <- skew(x[,,1], theta_x, theta_y)
    g <- skew(x[,,2], theta_x, theta_y)
    b <- skew(x[,,3], theta_x, theta_y)
    rgb <- rgbImage(r, g, b)
    rgb
  }
}