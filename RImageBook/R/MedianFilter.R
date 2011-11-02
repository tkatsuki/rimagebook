MedianFilter <- function(img, radius=1) {
  # default radius is 1, which means 3x3 median filter
  r <- radius
  row <- dim(img)[1]
  col <- dim(img)[2]
  fat_img <- rbind(numeric(row+2*r), 
                   cbind(numeric(col), img, numeric(col)), 
                   numeric(row+2*r))  # add 0 to the periphery
  a <- matrix(0, row, col) # prepare matrix
  for(i in 1:row) for (j in 1:col){
    a[i,j] <- median(fat_img[(i+r):(i+2*r),(j+r):(j+2*r)])
  }
  display(a/255)  # display image
}