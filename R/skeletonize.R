skeletonize <- function(x){
  s <- matrix(1, nrow(x), ncol(x)) # ”’Ž†‚ð—pˆÓ
  skel <- matrix(0, nrow(x), ncol(x)) # •‚¢”wŒi‚ð—pˆÓ
  kern <- makeBrush(3, shape="diamond") # \‘¢—v‘f‚Ìì¬
  while(max(s)==1){
    k <- opening(x, kern) # ƒI[ƒvƒjƒ“ƒOˆ—
    s <- x-k # Œ³‰æ‘œ‚Æ‚Ì·•ª‚ð‚Æ‚é
    skel <- skel | s # ·•ª‚ÌŒ‹‰Ê‚ðœŠi‚Ìˆê•”‚Æ‚·‚é
    x <- erode(x, kern) # Žûkˆ—
  }
  return(skel)
}