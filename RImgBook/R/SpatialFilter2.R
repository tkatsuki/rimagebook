SpatialFilter2 <- function(img, weight, r=1) {
  row <- nrow(img)
  col <- ncol(img)
  w <- as.vector(weight)
  # padding
  img <- rbind(matrix(0, r, col+2*r), 
               cbind(matrix(0, row, r), img, matrix(0, row, r)), 
               matrix(0, r, col+2*r))
  # stacking
  stack <- array(c(w[1]*img[1:row, 1:col],
                   w[2]*img[1:row, 2:(col+1)], 
                   w[3]*img[1:row, 3:(col+2)],
                   w[4]*img[2:(row+1), 1:col], 
                   w[5]*img[2:(row+1), 2:(col+1)],
                   w[6]*img[2:(row+1), 3:(col+2)],  
                   w[7]*img[3:(row+2), 1:col],
                   w[8]*img[3:(row+2), 2:(col+1)],
                   w[9]*img[3:(row+2), 3:(col+2)]), 
                 c(row, col, 9))
  a <- rowSums(stack, dim=2)
}