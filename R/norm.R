.norm <- function(x) {  			# データの正規化
 nx <- x - sum(x)/length(x)
 nx <- nx/sqrt(sum(nx*nx))
 nx
}