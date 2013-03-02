readAVI <- function(filepath){
  require(RImageBook)
  con <- file(filepath, open="rb")
  rawdata <- readBin(con, "raw", file.info(filepath)$size)
  close(con)

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

  # These are hard-coded in avih 
  img.w <- raw2int(rev(rawdata[65:68]))
  img.h <- raw2int(rev(rawdata[69:72]))
  total.frame <- raw2int(rev(rawdata[49:52]))
  img.data <- array(0, dim=c(img.w, img.h, total.frame))
  
  hdrl <- readBlock(rawdata, 13)
  offset <- hdrl[[4]][1]
  repeat{
    movi <- readBlock(rawdata, offset)
    if(movi[[1]][1]=="movi") break
    offset <- movi[[4]][1]
  }
  
  offset <- movi[[3]][1]
  i <- 1
  repeat{
    block <- readBlock(rawdata, offset)
    size <- block[[3]][2]-block[[3]][1]+1
    if(grepl("d", block[[1]][1]) == T && size!=0 && grepl("idx", block[[1]][1]) == F){
      img.data[,,i] <- matrix(as.integer(rawdata[block[[3]][1]:block[[3]][2]]), img.w, img.h)
      i <- i + 1
    } else if (grepl("b", block[[1]][1]) == F && grepl("d", block[[1]][1]) == F) break
    offset <- block[[4]][1]
  }
  img.data
}
    