readAVI <- function(filepath, start=1, end=0){
  require(RImageBook)
  offsetindex <- c()
  nindex <- c()
  indexsize <- c()
  
  # Read header reagion
  con <- file(filepath, open="rb")
  riff <- readBin(con, "raw", 0x14)
  hdrl <- readBin(con, "raw", raw2num(rev(riff[17:20])))
  header <- c(riff, hdrl)
  
  # These are hard-coded in avih
  n.stream <- raw2num(rev(header[57:60]))
  img.w <- raw2num(rev(header[65:68]))
  img.h <- raw2num(rev(header[69:72]))
  img.size <- img.w * img.h
  
  readBlock <- function(data, start){
    if(identical(data[start:(start+3)], charToRaw("LIST"))){
      listSize <- raw2num(rev(data[(start+4):(start+7)]))
      listType <- data[(start+8):(start+11)]
      listData <- c(start+12, start+7+listSize) # start and end position of list data
      nextOffset <- start+7+listSize+1 # Start position of the next block
      return(list(rawToChar(listType), listSize, listData, nextOffset))
      
    } else if(identical(data[start:(start+3)], charToRaw("JUNK"))){
      JUNKSize <- raw2num(rev(data[(start+4):(start+7)]))
      JUNKData <- c(start+8,start+7+JUNKSize) # start and end position of JUNK
      nextOffset <- start+7+JUNKSize+1 # Start position of the next block
      return(list("JUNK", JUNKSize, JUNKData, nextOffset))
      
    } else { # must be a chunk
      ckId <- data[start:(start+3)]
      ckSize <- raw2num(rev(data[(start+4):(start+7)]))
      ckData <- c(start+8,start+7+ckSize) # start and end position of chunk
      nextOffset <- start+7+ckSize+1 # Start position of the next block
      return(list(rawToChar(ckId), ckSize, ckData, nextOffset))
    }
  }
  
  offsetavih <- 25
  avih <- readBlock(header, offsetavih)
  offsetstrl <- avih[[4]][1] # Offset to the first stream chunk
  
  # Look for a video stream
  for(i in 1:n.stream){
    strl <- readBlock(header, offsetstrl) 
    offsetstrh <- strl[[3]][1]
    strh <- readBlock(header, offsetstrh)
    strtype <- header[(strh[[3]][1]):(strh[[3]][1]+3)]
    if(rawToChar(strtype)=="vids") {
      offsetstrf <- strh[[4]][1]
      offsetstrl <- strl[[4]][1]
    } else {
      offsetstrl <- strl[[4]][1]
    }
    i <- i + 1
  }
  
  strf <- readBlock(header, offsetstrf)
  offsetindex <- strf[[4]][1]
  sindex <- readBlock(header, offsetindex)
  
  odml <- readBlock(header, offsetstrl)
  
  if(odml[[1]][1]=="odml") { # If true, this file is avi2, openDML format 
    
    # Get the real total number of frames
    total.frame <- raw2num(rev(header[(odml[[3]][1]+8):(odml[[3]][1]+11)]))  

    # Set the last frame if not specified by user
    if(end==0) end <- total.frame
    print(paste("Read ", start, "-", end, " of ", total.frame, " frames", sep=""))
    
    # How many super-index are there?
    nsindex <- raw2num(rev(header[(sindex[[3]][1]+4):(sindex[[3]][1]+7)])) 
    
    # Get the offset and size of standard indexes
    for(i in 1:nsindex){
      offsetindex[i] <- raw2num(rev(header[(sindex[[3]][1]+24+(i-1)*16):(sindex[[3]][1]+31+(i-1)*16)])) # Can be larger than max integer value, so use double
      indexsize[i] <- raw2num(rev(header[(sindex[[3]][1]+32+(i-1)*16):(sindex[[3]][1]+35+(i-1)*16)]))
      nindex[i] <- raw2num(rev(header[(sindex[[3]][1]+36+(i-1)*16):(sindex[[3]][1]+39+(i-1)*16)])) # How many indexes are there in each index chunk
    }
    
    blockpos <- cumsum(nindex)
    startblock <- which(start <= blockpos)[1] # The block where "start" frame is located
    endblock <- min(which(end <= blockpos)) # The block where "end" frame is located
    
    # Calculate the relative position within each block
    if(startblock==1) {
      startpos <- start 
      } else {
        startpos <- start - blockpos[startblock-1]
      }
    if(endblock==1) {
      endpos <- end
    } else {
    endpos <- end - blockpos[endblock - 1]
    }
    
    # If start and end is in the same block
    if(startblock == endblock){
      # Get index from the start position
      seek(con, where = offsetindex[startblock]) # Move to the starting index chunk
      index <- readBin(con, "raw", indexsize[startblock]) # Load the entire index chunk
      indextype <- index[17:20]
      baseoffset <- raw2num(rev(index[21:28]))
      idxmat <- index[33:(33 + 8*nindex[startblock]-1)]
      idxmat <- matrix(idxmat, ncol=8, byrow=T)
      
      # Prepare a raw vector for storing image data
      nframes <- end - start + 1
      img.data <- raw(img.w*img.h*nframes)
      
      frame.start <- baseoffset + raw2num(rev(idxmat[startpos,1:4]))
      frame.size <- raw2num(rev(idxmat[1,5:8]))
      frame.last <- baseoffset + raw2num(rev(idxmat[endpos,1:4])) + frame.size
      
      # Load a desired video region
      seek(con, where = frame.start - 1)
      imgrawdata <- readBin(con, "raw", frame.last-frame.start)
      close(con)
      
      # Convert index into position information only
      idx <- apply(idxmat[startpos:endpos,1:4], 1, function(x) raw2num(rev(x))) - 
        raw2num(rev(idxmat[startpos,1:4])) + 1
      
      # Extract image 
      for(i in 1:nframes){
        img.data[(frame.size*(i-1)+1):(frame.size*i)] <- imgrawdata[idx[i]:(idx[i]+frame.size-1)]
      }
      rm(imgrawdata)
      array(as.integer(img.data), dim=c(img.w, img.h, nframes))
      
    } else {
      imglist <- list()
      
      for(i in startblock:endblock){
        seek(con, where = offsetindex[i]) # Move to the starting index chunk
        index <- readBin(con, "raw", indexsize[i]) # Load the entire index chunk
        indextype <- index[17:20]
        baseoffset <- raw2num(rev(index[21:28]))
        idxmat <- index[33:(33 + 8*nindex[i]-1)]
        idxmat <- matrix(idxmat, ncol=8, byrow=T)        
        frame.size <- raw2num(rev(idxmat[1,5:8]))
        
        # Position within the block
        if(i == startblock) {
          frame.start <- baseoffset + raw2num(rev(idxmat[startpos,1:4]))
          startframe <- startpos
        } else {
          frame.start <- baseoffset + raw2num(rev(idxmat[1,1:4]))
          startframe <- 1
        }
        if(i == endblock) {
          frame.last <- baseoffset + raw2num(rev(idxmat[endpos,1:4])) + frame.size
          endframe <- endpos
        } else {
          frame.last <- baseoffset + raw2num(rev(idxmat[nrow(idxmat),1:4])) + frame.size
          endframe <- blockpos[i]-blockpos[i-1]
        }
    
        # Prepare a raw vector for storing image data
        nframes <- endframe - startframe + 1
        img.data <- raw(img.w*img.h*nframes)
      
        # Load the desired video region
        seek(con, where = frame.start - 1)
        imgrawdata <- readBin(con, "raw", frame.last-frame.start)

        # Convert idxmat into a vector of position information
        if(startframe==endframe) {
          idx <- raw2num(rev(idxmat[startframe,1:4])) - raw2num(rev(idxmat[startframe,1:4])) + 1
        }else{
        idx <- apply(idxmat[startframe:endframe,1:4], 1, function(x) raw2num(rev(x))) - 
          raw2num(rev(idxmat[startframe,1:4])) + 1
        }
        # Extract image 
        for(n in 1:nframes){
          img.data[(frame.size*(n-1)+1):(frame.size*n)] <- imgrawdata[idx[n]:(idx[n]+frame.size-1)]
        }
        
        imglist[[i]] <- array(as.integer(img.data), dim=c(img.w, img.h, nframes))      
      }
      close(con)
      rm(imgrawdata)
      rm(img.data)
      array(unlist(imglist), dim=c(img.w, img.h, end-start+1))
    }
    
  } else {
    # Old avi format
    # Get position of movi list
    seek(con, where = 0)
    header <- readBin(con, "raw", 0x3000)
    hdrl <- readBlock(header, 13)
    offset <- hdrl[[4]][1]
    repeat{
      movi <- readBlock(header, offset)
      if(movi[[1]][1]=="movi") break
      offset <- movi[[4]][1]
    }
    offset <- movi[[3]][1]
    
    total.frame <- raw2num(rev(header[49:52])) # For old format only
    
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
    
    frame.start <- movi[[3]][1] + raw2num(rev(vididxmat[start,9:12])) + 4
    frame.size <- raw2num(rev(vididxmat[1,13:16]))
    frame.last <- movi[[3]][1] + raw2num(rev(vididxmat[end,9:12])) + 4 + frame.size
    
    # Load a desired video region
    seek(con, where = frame.start - 1)
    imgrawdata <- readBin(con, "raw", frame.last-frame.start)
    close(con)
    
    # Convert index into position information only
    vididx <- apply(vididxmat[start:end,9:12], 1, function(x) raw2num(rev(x))) - 
      raw2num(rev(vididxmat[start,9:12])) + 1
    
    # Extract image 
    for(i in 1:nframes){
      img.data[(frame.size*(i-1)+1):(frame.size*i)] <- imgrawdata[vididx[i]:(vididx[i]+frame.size-1)]
    }
  }
  rm(imgrawdata)
  array(as.integer(img.data), dim=c(img.w, img.h, nframes))
}
