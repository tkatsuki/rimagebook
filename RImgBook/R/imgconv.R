imgconv <- function(dirname=0, format1, format2, quality=100){
  if(dirname == 0){
    dirname <- readline("Enter a directory name:")
  }
  filelist <- list.files(dirname, pattern=format1)
  filelist <- substr(filelist, 1, nchar(filelist)-4)
	for (i in 1:length(filelist)){
    img <- readImage(paste("./", dirname, "/", filelist[i], ".", 
                           format1, sep=""))
    writeImage(img, file=paste("./", dirname, "/", filelist[i], ".", 
                               format2, sep=""), quality=quality)
	}
}