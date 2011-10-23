medianfilter2 <- function(img,r = 1) {
  if(length(dim(img))==2) {
      ret <- .Call("RWrapperMedianFilter",
        arg1 = img,
        arg2 = as.integer(r))
  } else {
    ret <- array(img[1,1,1],dim = dim(img))
    for( i in 1:dim(img)[3] ) {
      ret[,,i] <- medianfilter2(img[,,i],r)
    }
  }
  ret
}

