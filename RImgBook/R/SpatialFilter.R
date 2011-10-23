SpatialFilter <- function(img, weight) {
	wr <- nrow(weight)
	wc <- ncol(weight)
	row <- nrow(img)
	col <- ncol(img)
	a <- matrix(0, row, col) # prepare matrix
	for(i in wr:(row-wr+1)) for(j in wc:(col-wc+1)) {
	      a[i,j] <- crossprod(as.vector(img[(i-wr+1):i,(j-wc+1):j]),
                                  as.vector(weight))
	}
	a
}
