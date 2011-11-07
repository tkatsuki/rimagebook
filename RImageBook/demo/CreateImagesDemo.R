bg <- matrix(0, 256, 256)
display(bg)
grad <- matrix(c(0:255)/255, 256, 256)
display(grad)
x <- 0:65535
wave <- matrix(sin(x*pi/63.7), 256, 256)
display(wave)
w <- 256
h <- 256
s <- 40                                           # \(\sigma\)‚ğw’è
fn <- function(x, y, s) exp(-(x^2+y^2)/(2*s^2))   # ŠÖ”‚ğ’è‹`
x <- seq(-floor(w/2), floor(w/2), len=w)          # xÀ•W‚Ì”ÍˆÍ
y <- seq(-floor(h/2), floor(h/2),len=h)           # yÀ•W‚Ì”ÍˆÍ
w <- outer(x, y, fn, s)                           # ˆê”Ê‰»ŠOÏŠÖ”
display(normalize(w))
bg <- matrix(0, 256, 256)                        # ”wŒi‚Ìì¬
cr <- drawCircle(bg, 100, 100, 50, 1)            # ‰~ü‚ğ•`‚­
cr <- drawCircle(cr, 160, 160, 20, 1, fill=TRUE) # “h‚è‚Â‚Ô‚µ‚½‰~‚ğ•`‚­
display(cr)
theta <- seq(0, 2 * pi, length=(100))
x <- 200 + 100 * cos(theta)
y <- 200 + 30 * sin(theta)
plot(x, y, type = "l")
par(plt=c(0, 1, 0, 1), xaxs="i", yaxs="i") # ì}İ’è‚ğ•ÏX
theta <- seq(0, 2 * pi, length=(100))
x <- 200 + 100 * cos(theta)
y <- 200 + 30 * sin(theta)
                                           # o—Íæ‚ğpngƒtƒ@ƒCƒ‹‚Éİ’è
png(filename = "temp.png", width = 400, height = 400, bg = "black")
                                           # ì}‚·‚é
plot(x, y, type = "l", axes=F, col="white", xlim=c(0, 400), ylim=c(0, 400))
dev.off()                                  # ƒtƒ@ƒCƒ‹‚Ö‚Ìo—Í‚ğŠ®—¹
img <- readImage("temp.png")               # o—Í‚µ‚½ƒtƒ@ƒCƒ‹‚ğ“Ç‚İ‚ñ‚ÅŠm”F
display(img)
library("shape")
par(plt=c(0, 1, 0, 1), xaxs="i", yaxs="i")
png(filename = "temp.png", width = 400, height = 400, bg = "black")
emptyplot(xlim = c(0, 400), ylim = c(0, 400))
filledellipse(rx1 = 100, ry1 = 200, mid = c(200, 200), 
              angle = 30, col = "white")
filledellipse(rx1 = 100, ry1 = 100, rx2 = 50, ry = 50, 
              mid = c(200, 200), col = "gray")
dev.off()
img <- readImage("temp.png")
display(img)