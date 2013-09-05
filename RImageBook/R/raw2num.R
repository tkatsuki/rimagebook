raw2num <- function(rawdata) {
  return(as.numeric(paste("0x", paste(rawdata, collapse=""), sep="")))
}