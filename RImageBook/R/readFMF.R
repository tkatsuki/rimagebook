readFMF <- function(filepath, start=1, end=0){
  require(RImageBook)
  con <- file(filepath, open="rb")
  fmf_header <- readBin(con, "raw", 28)
  version <- raw2int(rev(fmf_header[1:4]))
  if(version != 1) stop("Only version 1 is supported")
  f_height <- raw2int(rev(fmf_header[5:8]))
  f_width <- raw2int(rev(fmf_header[9:12]))
  bytes_per_chunk <- raw2num(rev(fmf_header[13:20]))
  max_n_frames <- raw2num(rev(fmf_header[21:28]))
  if(end==0 | end > max_n_frames) end <- max_n_frames
  nframes <- end - start + 1
  startpos <- 28 + 1 + (start-1)*bytes_per_chunk
  endpos <- 28 + 1 + end*bytes_per_chunk - 1
  index <- list()
  for(i in 1:nframes){
    index[[i]] <- ((i-1)*bytes_per_chunk + 9):(i*bytes_per_chunk)
  }
  index <- unlist(index)  
  seek(con, where = startpos - 1)
  imgrawdata <- readBin(con, "raw", endpos-startpos+1)
  close(con)
  print(paste("Read ", start, "-", end, " of ", max_n_frames, " frames", sep=""))
  array(as.integer(imgrawdata[index]), dim=c(f_width, f_height, nframes))
}