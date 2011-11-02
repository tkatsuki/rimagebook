w <- matrix(1, 256, 256)
# 16‰æ‘f‚²‚Æ‚É2‰æ‘f‚Ì”’‰æ‘f‚ð‚à‚Â256‰æ‘f‚Ìü‚ðì¬
v <- c(rep(c(rep(0, 14), 1, 1), 16)) 
a <- w * v                                # s—ñ‚ÌÏ‚ÅcŽÈ‚ðì‚é
b <- t(a)                                 # “]’u‚µ‚Ä‰¡ŽÈ‚ðì‚é
c <- a & b                                # AND‰‰ŽZ
d <- a | b                                # OR‰‰ŽZ
e <- matrix(0, 256, 256)
e <- drawCircle(e, 128, 128, 50, 1, TRUE) # ‰~‚ð•`‚­
f <- xor(d, e)                            # XOR‰‰ŽZ
display(a)
display(b)
display(c)
display(d)
display(e)
display(f)