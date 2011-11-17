readAVI <- function(filepath){
  con <- file(filepath, open="rb")
  rawdata <- readBin(con, "raw", file.info(filepath)$size)
  close(con)

  JUNK <- raw(4)
  JUNK[1] <- as.raw(0x4a)
  JUNK[2] <- as.raw(0x55)
  JUNK[3] <- as.raw(0x4e)
  JUNK[4] <- as.raw(0x4b)

  img.w <- raw2int(rev(rawdata[65:68]))
  img.h <- raw2int(rev(rawdata[69:72]))
  total.frame <- raw2int(rev(rawdata[49:52]))
  hdrl.len <- raw2int(rev(rawdata[17:20]))

  if (identical(rawdata[(hdrl.len+21):(hdrl.len+24)], JUNK)){
    junk.len <- raw2int(rev(rawdata[(hdrl.len+25):(hdrl.len+28)]))
    data.len <- raw2int(rev(rawdata[(hdrl.len+33+junk.len):(hdrl.len+36+junk.len)]))-4
  }else{
    junk.len <- 0
    data.len <- raw2int(rev(rawdata[(hdrl.len+25):(hdrl.len+28)]))-4
  }
  data.chunk <- rawdata[(hdrl.len+33+8+junk.len):(hdrl.len+33+8+junk.len+data.len-1)]
  img.data <- array(0, dim=c(img.w, img.h, total.frame))

    for (i in 1:total.frame){
      last <- (img.w*img.h+8)*i
      start <- ((img.w*img.h+8)*(i-1)+9)
      img.data[,,i] <- matrix(as.integer(data.chunk[start:last]), img.w, img.h) 
    }
  img.data
}
    
