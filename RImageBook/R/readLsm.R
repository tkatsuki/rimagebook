readLsm <- function(filename) {
  # This function reads 8 bit Zeiss lsm files.
  imagedata <- c()
  imagetags <- data.frame()
  n <- 1
  
  # Open a lsm file and close it
  con <- file(filename, open="rb")
  raw <- readBin(con, "raw", file.info(filename)$size)
  close(con)
  
  # A function that returns integer value of a directory entry 
  value <- function(tag1, tag2, IFD){
    tag <- raw2int(c(tag2, tag1))
    len <- raw2int(rev(IFD[1:2]))
    IFDmat <- matrix(IFD[3:(2+12*len)], ncol=12, byrow=T)
    tags <- apply(IFDmat[,2:1], 1, raw2int)
    val <- raw2int(rev(IFDmat[which(tags==tag),9:12]))
    val
  }
  
  # A function that collects image information tags. Thumbnails are excluded.
  info <- function(offset, n, imageinfo){
    if (offset == 0) { return(imageinfo) }
    imageinfosize <- raw[(offset+1):(offset+2)]
    tmpinfo <- (raw[(offset+1):(offset+12*raw2int(rev(imageinfosize))+2+4)])
    thum <- value("fe", "00", tmpinfo)
    if (thum == 0){
      imageinfo <- append(imageinfo, list(tmpinfo))
      info(raw2int(rev(imageinfo[[n]])[1:4]), (n+1), imageinfo)
    } else { # Skip thumbnails
      info(raw2int(rev(tmpinfo)[1:4]), n, imageinfo)
    }
  }
  
  
  imagetags <- info(raw2int(rev(raw[0x5:0x8])), 1, imagetags)
  
  # Check compression
  if(value("03", "01", imagetags[[1]]) == 5) stop("Only uncompressed images can be read.")
  
  # Number of frames
  nf <- length(imagetags)
  
  # Number of channels
  nch <- value("15", "01", imagetags[[1]])
  
  # Size of the image
  w <- value("00", "01", imagetags[[1]])
  h <- value("01", "01", imagetags[[1]])
  
  # Bits per pixel
  if(nch==1) {
    bitspersample <- value("02", "01", imagetags[[1]])
  }else{
    bpsoffset <- value("02", "01", imagetags[[1]])
    bitspersample <- raw2int(rev(raw[(bpsoffset+1):(bpsoffset+2)]))
  }
  if(bitspersample != 8) stop("Only 8 bit images are supported.") 
  
  # Generate byte data
  outputimg <- array(0, dim=c(w, h, nch, nf))
  ByteGenerator <- function(i, j){
    
    # pixel data start point
    if(nch==1){
      px.start <- value("11", "01", imagetags[[j]]) + 1
    }else{
      px.start <- raw2int(rev(raw[(value("11", "01", imagetags[[j]])+1+(i-1)*4):
                                    (value("11", "01", imagetags[[j]])+4+(i-1)*4)]))+1
    }

    # Collect image data
    imagesize <- w*h
    imagedata <- raw[px.start:(px.start-1+imagesize)]
    matrix(as.numeric(imagedata), w, h)
  }
  
  for (j in 1:nf) for(i in 1:nch){
    outputimg[,,i,j] <- ByteGenerator(i, j)    
  }
  
  # Return an array of 8 bit 0 to 1 intensity
  return(outputimg/255)
}