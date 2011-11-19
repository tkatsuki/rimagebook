## Demo for p.72 Fig.4.25
w <- matrix(1, 256, 256)
v <- c(rep(c(rep(0, 14), 1, 1), 16)) 
a <- w * v
b <- t(a)
c <- a & b
d <- a | b
e <- matrix(0, 256, 256)
e <- drawCircle(e, 128, 128, 50, 1, TRUE)
f <- xor(d, e)
display(a)
display(b)
display(c)
display(d)
display(e)
display(f)