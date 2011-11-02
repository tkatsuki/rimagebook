data <- c(0, 0, 0, 0, 255, 220, 200, 100, 100, 100, 0, 0, 0, 0)

nn1d <- function(x,y) {
   i <- floor(x + 0.5)
   y[i]
}
plot(data, xlim=c(3, 10), ylim=c(-20, 300))
curve(nn1d(x, data), xlim=c(3, 10), ylim=c(-10, 300), lty=1, add=TRUE)

linear1d <- function(x,y) {
   i <- floor(x)
   t <- x - i
   y[i] * (1-t) + y[i+1] * t
}
plot(data, xlim=c(3, 10), ylim=c(-20, 300))
curve(linear1d(x, data), xlim=c(3, 10), lty=1, add=TRUE)

lanczos1d <- function(x,y,a) {
   i <- floor(x)
   t <- x - i
   if(a==2) {
     y[i-1]*lanczos(1+t,a) + y[i] * lanczos(t,a) + y[i+1] * lanczos(1-t,a) + 
       y[i+2] * lanczos(2-t,a)
   } else {
     y[i-2] * lanczos(2+t,a) + y[i-1]*lanczos(1+t,a) + y[i] * lanczos(t,a) +
       y[i+1] * lanczos(1-t,a) + y[i+2] * lanczos(2-t,a) + y[i+3] * lanczos(3-t,a)
   }
}
plot(data, xlim=c(3, 10), ylim=c(-20, 300))
curve(lanczos1d(x, data, 2), xlim=c(3, 10), lty=1, add=TRUE)
curve(lanczos1d(x, data, 3), xlim=c(3, 10), lty=2, add=TRUE)
legend(7.2, 300, lty=c(1,2),legend=c("lanczos a=2","lonczos a=3"))

cubic1d <- function(x,y,...) {
   i <- floor(x)
   t <- x - i
   y[i-1]*cubic(1+t,...) + y[i] * cubic(t,...) + y[i+1] * cubic(1-t,...) + 
      y[i+2] * cubic(2-t,...)
}
plot(data, xlim=c(3, 10), ylim=c(-20, 300))
curve(cubic1d(x, data, -0.5), xlim=c(3, 10), lty=1, add=TRUE)
curve(cubic1d(x, data, -1), xlim=c(3, 10), lty=2, add=TRUE)
legend(8, 300, lty=c(1,2),legend=c("a=-0.5","a=-1"))

plot(data, xlim=c(3, 10), ylim=c(-20, 300))
plot(splinefun(data), xlim=c(3, 10), add=T)