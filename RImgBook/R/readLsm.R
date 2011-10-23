readLsm <- function(filename) {
# This function reads 8 bit Zeiss lsm files.
	imagedata <- c()
	imagetags <- data.frame()
	imagesize <- data.frame()
	n <- 1
  outputimg <- c()
  
# Open a lsm file and close it
	con <- file(filename, open="rb")
	raw <- readBin(con, "raw", file.info(filename)$size)
	close(con)

# A function that returns integer value of a directory entry 
	value <- function(tag1, tag2, imageinfo){
		n <- 3
		for (i in 1:raw2int(imageinfo[1:2])){
			if (imageinfo[n] == tag1 && imageinfo[n+1] == tag2)	{
				return(raw2int(rev(imageinfo[(n+8):(n+11)])))
			}
		n <- n + 12
		}
	}

# A function that collects image information tags
	info <- function(offset, n, imageinfo){
		if (raw2int(offset) == 0) { return(imageinfo) }
		imageinfosize <- raw[(as.integer(offset)+1):(as.integer(offset)+2)]
		imageinfo <- append(imageinfo, 
					list((raw[(as.integer(offset)+1):
					(as.integer(offset)+12*raw2int(rev(imageinfosize))+2+4)])))
		info(raw2int(rev(imageinfo[[n]])[1:4]), (n+1), imageinfo)
	}
	imagetags <- info(raw[0x5], 1, imagetags)

# Number of channels
	nch <- value("15", "01", imagetags[[1]])
  
# Size of the image
  w <- value("00", "01", imagetags[[1]])
  h <- value("01", "01", imagetags[[1]])
  
# Bits per pixel
  bitspersample <- as.integer(raw[(value("02", "01", imagetags[[1]])+1)])


# Generate byte data
	ByteGenerator <- function(i){

# pixel data start point
    px.start <- raw2int(rev(raw[(value("11", "01", imagetags[[1]])+1+(i-1)*4):
                                (value("11", "01", imagetags[[1]])+4+(i-1)*4)]))+1
                              
# Collect image data
		if (bitspersample != 8) {
      return("Only 8 bit images are supported")
    }else{
		  imagesize <- w*h
		  imagedata <- raw[px.start:(px.start-1+imagesize)]
		}
    return(matrix(as.numeric(imagedata), w, h))
    }
  for (i in 1:nch){
	outputimg[[i]] <- ByteGenerator(i)
	}

# Return an array of 8 bit 0 to 1 intensities
  return(abind(outputimg, along=3)/255)
}