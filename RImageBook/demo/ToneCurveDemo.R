## Demo for p.55 Fig.4.10
par(ps=20, mar = c(5, 5, 1, 1))
curve(1*x,0,255, xlab="Input intensity", ylab="Output intensity", xlim=c(0, 250), ylim=c(0, 250))
curve((255/150*x-255/3),50,200, axes=F, xlab="", ylab="", xlim=c(0, 260), ylim=c(0, 260))
par(new=T)
curve(0*x,0,50, axes=F, xlab="", ylab="", xlim=c(0, 260), ylim=c(0, 260))
par(new=T)
curve(0*x+255,200,255, xlab="Input intensity (r)", ylab="Output intensity (s)", xlim=c(0, 260), ylim=c(0, 260))
curve(255/(1+(125/x)^5), 0, 255, xlab="Input intensity (r)", ylab="Output intensity (s)", xlim=c(0, 260), ylim=c(0, 260))