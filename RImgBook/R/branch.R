branch <- function(x){
 
 # prepare lookup tables
 h1 <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0,
0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1,
0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
0, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0,
1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0,
0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0)
   
 # define stacking function
 stacking <- function(img){
     r <- 1
     row <- nrow(img)
     col <- ncol(img)
 
     img <- rbind(matrix(0, r, col+2*r), 
     cbind(matrix(0, row, r), img, matrix(0, row, r)), 
     matrix(0, r, col+2*r))
 
     stack <- array(c(img[1:row, 2:(col+1)]*2^7,
                      img[1:row, 3:(col+2)]*2^6,
                      img[2:(row+1), 3:(col+2)]*2^5, 
                      img[3:(row+2), 3:(col+2)]*2^4,
                      img[3:(row+2), 2:(col+1)]*2^3,
                      img[3:(row+2), 1:col]*2^2,
                      img[2:(row+1), 1:col]*2^1,
                      img[1:row, 1:col]*2^0),
                      c(row, col, 8))
     stack
 }
  
     stack1 <- stacking(x)
 
 # convert stack to 8 bit integer values
   key1 <- rowSums(stack1, dim=2)
   
 # apply lookup table
   flag1 <- matrix(h1[key1+1], nrow(key1), ncol(key1))
   x1 <- x*flag1
   x1
   
}