raw2int <- function(rawdata) {
  return(as.integer(paste("0x", paste(rawdata, collapse=""), sep="")))
}