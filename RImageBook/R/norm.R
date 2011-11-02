.norm <- function(x) {  			# ƒf[ƒ^‚Ì³‹K‰»
 nx <- x - sum(x)/length(x)
 nx <- nx/sqrt(sum(nx*nx))
 nx
}