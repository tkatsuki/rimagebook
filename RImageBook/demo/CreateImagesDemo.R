## Demo for p.20 Fig.2.9
bg <- matrix(0, 256, 256)
display(bg, "Background image")

grad <- matrix(c(0:255)/255, 256, 256)
display(grad, "Gradient")

x <- 0:65535
wave <- matrix(sin(x*pi/63.7), 256, 256)
display(wave, "Wave pattern")

w <- 256
h <- 256
s <- 40
fn <- function(x, y, s) exp(-(x^2+y^2)/(2*s^2))
x <- seq(-floor(w/2), floor(w/2), len=w)
y <- seq(-floor(h/2), floor(h/2),len=h)
w <- outer(x, y, fn, s)
display(normalize(w), "Gaussian distribution")

bg <- matrix(0, 256, 256)
cr <- drawCircle(bg, 100, 100, 50, 1)
cr <- drawCircle(cr, 160, 160, 20, 1, fill=TRUE)
display(cr, "Circles")

## Demo for p.22 Fig.2.10
theta <- seq(0, 2 * pi, length=(100))
x <- 200 + 100 * cos(theta)
y <- 200 + 30 * sin(theta)
plot(x, y, type = "l")

theta <- seq(0, 2 * pi, length=(100))
x <- 200 + 100 * cos(theta)
y <- 200 + 30 * sin(theta)
par(plt=c(0, 1, 0, 1), xaxs="i", yaxs="i")
png(filename = "temp.png", width = 400, height = 400, bg = "black")
plot(x, y, type = "l", axes=F, col="white", xlim=c(0, 400), ylim=c(0, 400))
dev.off()
img <- readImage("temp.png")
display(img, "Ellipses")

if(!require(shape)){
  install.packages("shape")
  library("shape")
}
par(plt=c(0, 1, 0, 1), xaxs="i", yaxs="i")
png(filename = "temp.png", width = 400, height = 400, bg = "black")
emptyplot(xlim = c(0, 400), ylim = c(0, 400))
filledellipse(rx1 = 100, ry1 = 200, mid = c(200, 200), 
              angle = 30, col = "white")
filledellipse(rx1 = 100, ry1 = 100, rx2 = 50, ry = 50, 
              mid = c(200, 200), col = "gray")
dev.off()
img <- readImage("temp.png")
display(img, "Ellipses using shape package")
