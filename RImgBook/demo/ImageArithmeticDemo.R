girl <- readImage(system.file("images/mono/girl.bmp",package="RImageBook"))
woman <- readImage(system.file("images/mono/WOMAN.bmp",package="RImageBook"))
x <- matrix(0, nrow=256, ncol=256)
y <- matrix(1, nrow=256, ncol=256)
mask <- drawCircle(x, 130, 110, 60, col=1, fill=TRUE)
invmask <- drawCircle(y, 130, 110, 60, col=0, fill=TRUE)
girlface <- girl * mask
womanhole <- woman * invmask
display(girl)
display(woman)
display(mask)
display(invmask)
display(girlface)
display(womanhole)
display(girlface + womanhole)

blend <- array(dim = c(256, 256, 10)) # ‰æ‘œ‚ğŠi”[‚·‚é”z—ñ‚ğ—pˆÓ
for (i in 1:10){              # ƒ}ƒ‹ƒ`ƒy[ƒW‚Ì‰æ‘œ‚Æ‚µ‚ÄƒuƒŒƒ“ƒh‰æ‘œ‚ğì¬‚·‚é
   blend[,,i] <- (i/10)*girl + (1-i/10)*woman
 }
display(blend)

river <- readImage(system.file("images/river.jpg", package="RImageBook"))
pond <- readImage(system.file("images/pond.jpg", package="RImageBook"))
gradlr <- matrix(seq(0, 1, length.out=nrow(river)), nrow(river), ncol(river)) 
gradrl <- 1- gradlr
rivnd <- river * gradlr + pond * gradrl 
display(rivnd)
                    
engine <- readImage(system.file("images/engine.jpg", package="RImageBook"))
display(engine)
engineem <- emboss(engine)
display(engineem)
                    
w <- matrix(1, 256, 256)
# 16‰æ‘f‚²‚Æ‚É2‰æ‘f‚Ì”’‰æ‘f‚ğ‚à‚Â256‰æ‘f‚Ìü‚ğì¬
v <- c(rep(c(rep(0, 14), 1, 1), 16)) 
a <- w * v                                #@s—ñ‚ÌÏ‚ÅcÈ‚ğì‚é
b <- t(a)                                 #@“]’u‚µ‚Ä‰¡È‚ğì‚é
c <- a & b                                # AND‰‰Z
d <- a | b                                # OR‰‰Z
e <- matrix(0, 256, 256)
e <- drawCircle(e, 128, 128, 50, 1, TRUE) # ‰~‚ğ•`‚­
f <- xor(d, e)                            # XOR‰‰Z
display(a)                                # display(b)ˆÈ~‚Í—ª
display(b)
display(c)
display(d)
display(e)
display(f)