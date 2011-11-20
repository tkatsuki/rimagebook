## Demo for p.38 Fig.3.13
data <- c(0, 0, 0, 0, 255, 220, 200, 100, 100, 100, 0, 0, 0, 0)

# Plot data points
h <- 5
w <- 6.5
par(mar=c(3,3,1,0.5), mgp = c(1.9, 0.6, 0), tck= -0.02)
plot(data, xlim=c(3, 10), ylim=c(-40, 300), lty=1)

# Nearest neighbour interpolation
nn1d <- function(x,y) {
 i <- floor(x + 0.5)
 y[i]
}
plot(data, xlim=c(3, 10), ylim=c(-40, 300), lty=1)
curve(nn1d(x, data), xlim=c(3, 10), ylim=c(-10, 300), lty=1, add=TRUE)

# bi-linear interpolation
linear1d <- function(x,y) {
  i <- floor(x)
  t <- x - i
  y[i] * (1-t) + y[i+1] * t
}
plot(data, xlim=c(3, 10), ylim=c(-40, 300))
curve(linear1d(x, data), xlim=c(3, 10), lty=1, add=TRUE)

# Lanczos interpolation
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
plot(data, xlim=c(3, 10), ylim=c(-40, 300))
curve(lanczos1d(x, data, 2), xlim=c(3, 10), lty=1, add=TRUE)
curve(lanczos1d(x, data, 3), xlim=c(3, 10), lty=2, add=TRUE)
legend(7.9, 310, lty=c(1,2),legend=c("a = 2","a = 3"), bty="n")

# bi-cubic interpolation
cubic1d <- function(x,y,...) {
  i <- floor(x)
  t <- x - i
  y[i-1]*cubic(1+t,...) + y[i] * cubic(t,...) + y[i+1] * cubic(1-t,...) + 
    y[i+2] * cubic(2-t,...)
  }
plot(data, xlim=c(3, 10), ylim=c(-40, 300))
curve(cubic1d(x, data, -0.5), xlim=c(3, 10), lty=1, add=TRUE)
curve(cubic1d(x, data, -1), xlim=c(3, 10), lty=2, add=TRUE)
legend(7.2, 310, lty=c(1,2),legend=c("a = -0.5","a = -1"), bty="n")
arrows(5, 0, 4, -20)
arrows(4.6, 290, 5, 280)
text(6, 10, "Undershoot")
text(3.65, 300, "Overshoot")

# bi-cubic spline interpolation
plot(data, xlim=c(3, 10), ylim=c(-40, 300))
plot(splinefun(data), xlim=c(3, 10), add=T)
