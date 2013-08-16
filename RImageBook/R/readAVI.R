readAVI <- function(filepath, start=1, end=0){
  require(RImageBook)
  
  # Read header reagion only. Don't know how long JUNK chuncks can be. Use 0x3000 for now.
  con <- file(filepath, open="rb")
  header <- readBin(con, "raw", 0x3000)
  
  # These are hard-coded in avih 
  img.w <- raw2int(rev(header[65:68]))
  img.h <- raw2int(rev(header[69:72]))
  img.size <- img.w * img.h
  total.frame <- raw2int(rev(header[49:52]))
    
  readBlock <- function(data, start){
    if(identical(data[start:(start+3)], charToRaw("LIST"))){
      listSize <- raw2int(rev(data[(start+4):(start+7)]))
      listType <- data[(start+8):(start+11)]
      listData <- c(start+12, start+7+listSize) # start and end position of list data
      nextOffset <- start+7+listSize+1 # Start position of the next block
      return(list(rawToChar(listType), listSize, listData, nextOffset))
      
    } else if(identical(data[start:(start+3)], charToRaw("JUNK"))){
      JUNKSize <- raw2int(rev(data[(start+4):(start+7)]))
      JUNKData <- c(start+8,start+7+JUNKSize) # start and end position of JUNK
      nextOffset <- start+7+JUNKSize+1 # Start position of the next block
      return(list("JUNK", JUNKSize, JUNKData, nextOffset))
      
    } else { # must be a chunk
      ckId <- data[start:(start+3)]
      ckSize <- raw2int(rev(data[(start+4):(start+7)]))
      ckData <- c(start+8,start+7+ckSize) # start and end position of chunk
      nextOffset <- start+7+ckSize+1 # Start position of the next block
      return(list(rawToChar(ckId), ckSize, ckData, nextOffset))
    }
  }
  
  # Get position of movi list
  hdrl <- readBlock(header, 13)
  offset <- hdrl[[4]][1]
  repeat{
    movi <- readBlock(header, offset)
    if(movi[[1]][1]=="movi") break
    offset <- movi[[4]][1]
  }
  offset <- movi[[3]][1]
  
  # Load the index region
  idx.start <- movi[[4]][1]-1 # Start of the index
  seek(con, where = idx.start+8)
  idx1 <- readBin(con, "raw", file.info(filepath)$size-idx.start-8)
  
  # Shape the index into a matrix
  idxmat <- matrix(idx1, ncol=16, byrow=T)
  
  # Select valid video index
  vididxmat <- idxmat[idxmat[,3]==0x64 & idxmat[,4]==0x63 
                      & (idxmat[,13] != 0x00 | idxmat[,14] != 0x00 | idxmat[,15] != 0x00 | idxmat[,16] != 0x00),]

  # Check the last frame
  if(total.frame > nrow(vididxmat)) total.frame <- nrow(vididxmat)
  if(end==0 | end > nrow(vididxmat)) end <- total.frame
  
  # Prepare a vector for storing image data
  nframes <- end - start + 1
  img.data <- raw(img.w*img.h*nframes)
  
  frame.start <- movi[[3]][1] + raw2int(rev(vididxmat[start,9:12])) + 4
  frame.size <- raw2int(rev(vididxmat[1,13:16]))
  frame.last <- movi[[3]][1] + raw2int(rev(vididxmat[end,9:12])) + 4 + frame.size
  
  # Load a desired video region
  seek(con, where = frame.start - 1)
  imgrawdata <- readBin(con, "raw", frame.last-frame.start)
  close(con)
  
  # Convert index into position information only
  vididx <- apply(vididxmat[start:end,9:12], 1, function(x) raw2int(rev(x))) - 
    raw2int(rev(vididxmat[start,9:12])) + 1

  # Extract image 
  for(i in 1:nframes){
    img.data[(frame.size*(i-1)+1):(frame.size*i)] <- imgrawdata[vididx[i]:(vididx[i]+frame.size-1)]
  }
  array(as.integer(img.data), dim=c(img.w, img.h, nframes))
}