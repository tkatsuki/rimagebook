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
  seek(con, where = startpos - 1)
  imgrawdata <- readBin(con, "raw", endpos-startpos+1)
  close(con)
  imgdata <- raw(f_width*f_height*nframes)
  framesize <- f_width*f_height
  for(i in 1:nframes){
    imgdata[(framesize*(i-1)+1):(framesize*i)]<- imgrawdata[((i-1)*bytes_per_chunk + 9):(i*bytes_per_chunk)]
  } 
  print(paste("Read ", start, "-", end, " of ", max_n_frames, " frames", sep=""))
  rm(imgrawdata)
  array(as.integer(imgdata), dim=c(f_width, f_height, nframes))
}