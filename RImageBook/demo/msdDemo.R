## Demo for p.144 Fig.9.5
if(!require(adehabitatLT)){
  install.packages("adehabitatLT")
  library("adehabitatLT")
}
msdres1 <- c()
par(pty = "s")
par(mar = c(4, 0, 1, 0))
par(ps=22)
for (i in 1:10){
  toto <- simm.brown(1:1000, c(sample(0:400, 1), sample(0:400, 1)), h=0.5)
  plot(toto[[1]]$x, toto[[1]]$y, type="l", xlab="x", ylab="y", xlim=c(0, 400), ylim=c(0, 400))
  par(new=T)
  data <- cbind(toto[[1]]$x, toto[[1]]$y) 
  msdres1 <- cbind(msdres1, msd(data))
}

msdres2 <- c()
par(new=F)
for (i in 1:10){
  toto <- simm.brown(1:1000, c(sample(0:400, 1), sample(0:400, 1)), h=1)
  plot(toto[[1]]$x, toto[[1]]$y, type="l", xlab="x", ylab="y", xlim=c(0, 400), ylim=c(0, 400))
  par(new=T)
  data <- cbind(toto[[1]]$x, toto[[1]]$y) 
  msdres2 <- cbind(msdres2, msd(data))
}

par(new=F)
par(pty = "s")
ts <- matrix(seq(0.01, 0.01*nrow(msdres1), 0.01), 250, 10)
matplot(ts, msdres1, type="l", lty=1, col=1, log="xy", xlab="Time (s)", ylab=expression(MSD (nm^2)))
matlines(ts, msdres2, type="l", lty=2, col=1, log="xy", xlab="Time (s)", ylab=expression(MSD (nm^2)))
