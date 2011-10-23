findPeaks <- function(img) {
  mask <- img > 0
  m1 <- matrix(c(0, 0, 0, -1, 1, 0, 0, 0, 0), 3, 3, byrow=TRUE)
  m2 <- matrix(c(0, -1, 0, 0, 1, 0, 0, 0, 0), 3, 3, byrow=TRUE)
  m3 <- matrix(c(0, 0, 0, 0, 1, 0, 0, -1, 0), 3, 3, byrow=TRUE)
  m4 <- matrix(c(0, 0, 0, 0, 1, -1, 0, 0, 0), 3, 3, byrow=TRUE)

  peak1 <- filter2(img, m1)
  peak2 <- filter2(img, m2)
  peak3 <- filter2(img, m3)
  peak4 <- filter2(img, m4)

  peak1 <- peak1 > 0
  peak2 <- peak2 > 0
  peak3 <- peak3 > 0
  peak4 <- peak4 > 0

  img1234 <- peak1 & peak2 & peak3 & peak4
  img1234*mask
}