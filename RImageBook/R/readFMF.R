readFMF <- function(filepath, start=1, end=0, skip=0){
  require(RImageBook)
  con <- file(filepath, open="rb")
  fmf_header <- readBin(con, "raw", 28)
  version <- raw2int(rev(fmf_header[1:4]))
  if(version != 1) stop("Only version 1 is supported")
  f_height <- raw2num(rev(fmf_header[5:8]))
  f_width <- raw2num(rev(fmf_header[9:12]))
  framesize <- f_width*f_height
  bytes_per_chunk <- raw2num(rev(fmf_header[13:20]))
  max_n_frames <- raw2num(rev(fmf_header[21:28]))
  if(end==0 | end > max_n_frames) end <- max_n_frames
  nframes <- end - start + 1
  startpos <- 28 + 1 + (start-1)*bytes_per_chunk
  endpos <- 28 + 1 + end*bytes_per_chunk - 1
  seek(con, where = startpos - 1)
  if(skip==0){
    imgrawdata <- readBin(con, "raw", endpos-startpos+1)
    close(con)
    imgdata <- raw(framesize*nframes)
    for(i in 1:nframes){
      imgdata[(framesize*(i-1)+1):(framesize*i)]<- imgrawdata[((i-1)*bytes_per_chunk + 9):(i*bytes_per_chunk)]
    } 
    print(paste("Read ", start, "-", end, " of ", max_n_frames, " frames", sep=""))
    rm(imgrawdata)
    array(as.integer(imgdata), dim=c(f_width, f_height, nframes))
  } else{
    nframes <- length(seq(1, nframes, skip+1))
    imgdata <- raw(framesize*nframes)
    for(i in 1:nframes){
      imgrawdata <- readBin(con, "raw", bytes_per_chunk)
      imgdata[(framesize*(i-1)+1):(framesize*i)]<- imgrawdata[9:bytes_per_chunk]
      seek(con, where = skip*bytes_per_chunk, origin="current")
    }
    close(con)
    print(paste("Read ", start, "-", end, " of ", max_n_frames, " frames skipping every ", skip, " frames", sep=""))
    rm(imgrawdata)
    array(as.integer(imgdata), dim=c(f_width, f_height, nframes))
  }
}