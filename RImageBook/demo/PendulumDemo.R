pen <- readImage(system.file("images/pendulum.gif", package="RImageBook"))
pen <- 1-pen
pen <- thresh(pen, 50, 50, 0.5)
kern1 <- makeBrush(3, shape="disc")
pen2 <- opening(pen, kern1)
pend <- bwlabel(pen2)
mm <- cmoments(pend, pen)
ll <- sapply(mm, function(x) which(x[,'m.pxs']<=300 | x[,'m.y']<=50))
pens <- rmObjects(pend, ll)
pens <- pens > 0
pens <- bwlabel(pens)
display(pens)

a <- pen[,,6]
b <- pen[,,8]
c <- pen[,,10]
display(abs(a-b))
display(abs(b-c))
display(abs(a-b) & abs(b-c))

a <- pen[,,6]
b <- pen[,,7]
c <- pen[,,8]
display(abs(a-b))
display(abs(b-c))
display(abs(a-b) & abs(b-c))

gr <- matrix(0:399, 400, 400)
for(i in 1:126) pens[,,i] <- pens[,,i]*gr
pens <- equalize(pens)
pens <- normalize(pens)
pens <- pens@.Data
pen2 <- pen * (1-pens)
a <- pen2[,,6]
b <- pen2[,,7]
c <- pen2[,,8]
display(abs(a-b))
display(abs(b-c))
display(abs(a-b) & abs(b-c))

mm <- cmoments(pens, pen)
mm <- matrix(unlist(mm), ncol=4, byrow=TRUE)
mm

png(filename = "pendulumResult.png", width=400, height=400, bg="white")
par(plt=c(0, 1, 0, 1), xaxs="i", yaxs="i")
plot(mm[,3], mm[,4], axes=F, xlim=c(0, 400), ylim=c(0, 400))
lines(mm[,3], mm[,4])
dev.off()

resultimg <- readImage("pendulumResult.png")
resultimg <- flip(resultimg)
display(xor(resultimg, pen@.Data[,,1]))
