medianfilter <- function(img,r = 1) {
  if(length(dim(img))==2) {
    if(is.integer(img)) {
      ret <- .C("RWrapperMedianFilterI32",
        arg1 = matrix(as.integer(0),nrow(img),ncol(img)),
        arg2 = img,
        arg3 = nrow(img),
        arg4 = ncol(img),
        arg5 = as.integer(r),
        DUP = FALSE) $arg1
     } else {
      ret <- .C("RWrapperMedianFilterF64",
        arg1 = matrix(as.double(0),nrow(img),ncol(img)),
        arg2 = img,
        arg3 = nrow(img),
        arg4 = ncol(img),
        arg5 = as.integer(r),
        DUP = FALSE) $arg1
     }
  } else {
    ret <- array(img[1,1,1],dim = dim(img))
    for( i in 1:dim(img)[3] ) {
      ret[,,i] <- medianfilter(img[,,i],r)
    }
  }
  ret
}

