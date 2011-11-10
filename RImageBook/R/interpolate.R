interpolate <- function(img, x, y, r) {
  cx <- floor(x)
  cy <- floor(y)
  lx <- max(1,cx-r)
  rx <- min(cx+r+1,ncol(img))
  ly <- max(1,cy-r)
  ry <- min(cy+r+1,nrow(img))
  wx <- sinc(lx:rx - x)
  wy <- sinc(ly:ry - y)
  wx <- wx / sum(wx)
  wy <- wy / sum(wy)
  crossprod(wx, t(crossprod(wy, img[ly:ry,lx:rx])))
}