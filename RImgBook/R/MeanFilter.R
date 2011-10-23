MeanFilter <- function(img, radius=1) {
	size <- 2*radius+1
	SpatialFilter(img, matrix(rep(1/(size*size),size*size),size,size))
}
