readAVI <- function(filepath, start=1, end=0, skip=0, getFrames=F, crop=c(0,0,0,0), silent=F){
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
    if(getFrames==T) {
      close(con)
      return(total.frame)
    }
    # Check if start is correct
    if(start < 1) start <- 1
    # Set the last frame if not specified by user
    if(end==0) end <- total.frame
    if(end > total.frame) end <- total.frame
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
    
    # Building images
    imglist <- list()      
    for(i in startblock:endblock){
      # Move to each index chunk
      seek(con, where = offsetindex[i]) 
      # Load the entire index chunk
      index <- readBin(con, "raw", indexsize[i]) 
      # index is written relative to the baseoffset
      baseoffset <- raw2num(rev(index[21:28]))
      # Reshape index list into a matrix
      idxmat <- index[33:(33 + 8*nindex[i]-1)]
      idxmat <- matrix(idxmat, ncol=8, byrow=T)        
      # Get the frame size, should be equal to img.w*img.h
      frame.size <- raw2num(rev(idxmat[1,5:8])) 
      if(img.size!=frame.size) stop("Only grayscale videos are supported")
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
        endframe <- nindex[i]
      }        
      # Convert index matrix into position information only (relative to the file start point)
      idx <- apply(idxmat[startframe:endframe, 1:4, drop = FALSE], 1, function(x) raw2num(rev(x)) + baseoffset)
      nframes <- endframe - startframe + 1
      if(skip==0){   
        if(all.equal(crop, c(0,0,0,0))!=T){
          x1 <- crop[1]
          x2 <- crop[2]
          y1 <- crop[3]
          y2 <- crop[4]
          w <- x2-x1+1
          h <- y2-y1+1
          crop.size <- c(x2-x1+1)*c(y2-y1+1)
          img.data <- raw(crop.size*nframes)
          for(j in 1:nframes){
            seek(con, where = idx[j])
            tmpmat <- matrix(readBin(con, "raw", frame.size), ncol=img.w)
            img.data[(crop.size*(j-1)+1):(crop.size*j)] <-  as.vector(tmpmat[x1:x2,y1:y2])
          } 
          frame.size <- crop.size
        } else {
          # Prepare a raw vector for storing image data
          w <- img.w
          h <- img.h
          img.data <- raw(frame.size*nframes)    
          
          # Extract image 
          for(j in 1:nframes){
            seek(con, where = idx[j]) 
            img.data[(frame.size*(j-1)+1):(frame.size*j)] <-  readBin(con, "raw", frame.size)
          }
        }
        imglist[[i]] <- array(as.integer(img.data), dim=c(w, h, nframes))
      } else {
        nframes <- length(seq(1, nframes, skip+1))
        if(all.equal(crop, c(0,0,0,0))!=T){
          x1 <- crop[1]
          x2 <- crop[2]
          y1 <- crop[3]
          y2 <- crop[4]
          w <- x2-x1+1
          h <- y2-y1+1
          crop.size <- c(x2-x1+1)*c(y2-y1+1)
          img.data <- raw(crop.size*nframes)
          for(j in 1:nframes){
            seek(con, where = idx[1+(j-1)*skip])
            tmpmat <- matrix(readBin(con, "raw", frame.size), ncol=img.w)
            img.data[(crop.size*(j-1)+1):(crop.size*j)] <-  as.vector(tmpmat[x1:x2,y1:y2])
          }
          frame.size <- crop.size
        } else{
          w <- img.w
          h <- img.h
          img.data <- raw(frame.size*nframes)    
          
          # Extract image 
          for(j in 1:nframes){
            seek(con, where = idx[1+(j-1)*skip]) 
            img.data[(frame.size*(j-1)+1):(frame.size*j)] <-  readBin(con, "raw", frame.size)
          }
        }
        imglist[[i]] <- array(as.integer(img.data), dim=c(w, h, nframes)) 
      }      
    }
    if(silent==F) print(paste("Read every ", skip + 1, " frames from ", start, " to ", end, " of ", total.frame, " frames", sep=""))
    close(con)
    rm(img.data)
    tmpimg <- unlist(imglist)
    array(tmpimg, dim=c(w, h, length(tmpimg)/frame.size))
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
    
    # Load the index region
    idx.start <- movi[[4]][1]-1 # Start of the index
    seek(con, where = idx.start+8)
    idx1 <- readBin(con, "raw", file.info(filepath)$size-idx.start-8)
    
    # Shape the index into a matrix
    idxmat <- matrix(idx1, ncol=16, byrow=T)
    
    # Select valid video index
    vididxmat <- idxmat[idxmat[,3]==0x64 & (idxmat[,4]==0x62 | idxmat[,4]==0x63) 
                        & (idxmat[,13] != 0x00 | idxmat[,14] != 0x00 | idxmat[,15] != 0x00 | idxmat[,16] != 0x00),]
    
    # Check the last frame
    total.frame <- raw2num(rev(header[49:52])) # For old format only
    if(getFrames==T) {
      close(con)
      return(total.frame)
    }
    if(total.frame > nrow(vididxmat)) total.frame <- nrow(vididxmat)
    if(end==0 | end > nrow(vididxmat)) end <- total.frame
    
    # Prepare a vector for storing image data
    nframes <- end - start + 1   
    frame.size <- raw2num(rev(vididxmat[1,13:16]))
    if(img.size!=frame.size) stop("Only grayscale videos are supported")
    
    # Convert index into position information only
    idx <- apply(vididxmat[start:end, 9:12, drop = FALSE], 1, function(x) raw2num(rev(x))) + movi[[3]][1] + 4
    
    # Extract image
    if(skip==0){     
      if(all.equal(crop, c(0,0,0,0))!=T){
        x1 <- crop[1]
        x2 <- crop[2]
        y1 <- crop[3]
        y2 <- crop[4]
        w <- x2-x1+1
        h <- y2-y1+1
        crop.size <- c(x2-x1+1)*c(y2-y1+1)
        img.data <- raw(crop.size*nframes)
        for(i in 1:nframes){
          seek(con, where = idx[i]) 
          tmpmat <- matrix(readBin(con, "raw", frame.size), ncol=img.w)
          img.data[(crop.size*(i-1)+1):(crop.size*i)] <-  as.vector(tmpmat[x1:x2,y1:y2])
        }   
      } else {
        w <- img.w
        h <- img.h
        # Prepare a raw vector for storing image data
        img.data <- raw(frame.size*nframes)  
        for(i in 1:nframes){
          seek(con, where = idx[i]) 
          img.data[(frame.size*(i-1)+1):(frame.size*i)] <-  readBin(con, "raw", frame.size)
        } 
      }
    } else {
      nframes <- length(seq(1, nframes, skip+1))
      
      if(all.equal(crop, c(0,0,0,0))!=T){
        x1 <- crop[1]
        x2 <- crop[2]
        y1 <- crop[3]
        y2 <- crop[4]
        w <- x2-x1+1
        h <- y2-y1+1
        crop.size <- c(x2-x1+1)*c(y2-y1+1)
        img.data <- raw(crop.size*nframes)
        for(i in 1:nframes){
          seek(con, where = idx[1+(i-1)*skip])
          tmpmat <- matrix(readBin(con, "raw", frame.size), ncol=img.w)
          img.data[(crop.size*(i-1)+1):(crop.size*i)] <-  as.vector(tmpmat[x1:x2,y1:y2])
        } 
      }else{
        w <- img.w
        h <- img.h
        # Prepare a raw vector for storing image data
        img.data <- raw(frame.size*nframes)    
        for(i in 1:nframes){
          seek(con, where = idx[1+(i-1)*skip]) 
          img.data[(frame.size*(i-1)+1):(frame.size*i)] <-  readBin(con, "raw", frame.size)
        }
      }
    }
    close(con)
    if(silent==F) print(paste("Read ", start, "-", end, " of ", total.frame, " frames", sep="")) 
    array(as.integer(img.data), dim=c(w, h, nframes))
  }
}