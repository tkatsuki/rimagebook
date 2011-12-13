histogram <- function(x, breaks=512, xlim=c(0, 1), ylim=NULL, main="", col="black") {
  if(is.Image(x)==T){
    hist(x@.Data, breaks=breaks, main=main, xlim=c(0, 1), xlab="Intensity", ylim=ylim, col=col)
  } else {
    if(class(x)[1]=="imagedata"){
      hist(x, breaks=256, main=main, xlim=c(0, 255), xlab="Intensity", ylim=ylim, col=col)
    } else {
      hist(x, breaks=breaks, main=main, xlim=xlim, xlab="Intensity", ylim=ylim, col=col)  
      }
    }
}