AnisotropicFilter <- function(Img,Iter,Coef=0.1){
  a <- as.double(Img)
  .C("AnisotropicFilterF64",arg1=a,arg2=as.integer(c(dim(Img),1)),
      arg3=as.integer(Iter),arg4=as.double(Coef),DUP=FALSE)
  imageData(matrix(a,nrow(Img),ncol(Img)))
}
