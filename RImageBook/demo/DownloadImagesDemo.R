## Demo codes for p.22
rlogo <- readImage("http://www.r-project.org/Rlogo.jpg") 
display(rlogo, "Downloaded image")
writeImage(rlogo, "Rlogo.jpg")

## Demo codes for p.23 Fig.2.11
if(!require(RgoogleMaps)){
  install.packages("RgoogleMaps")
  library("RgoogleMaps")
}
mapurl <- GetMap(c(37,138), 5, maptype="satellite", RETURNIMAGE=FALSE)
map <- readImage(mapurl)
mapgr <- channel(map, "gray")
display(mapgr, "Google map")

## Demo codes for p.24
## Requires RCurl and Rcompression packages
## Rcompression is available only for R-2.13 or older, and has to be installed manually
## See http://www.omegahat.org/Rcompression/ for details
if(!require(RCurl)){
  install.packages("RCurl")
  library("RCurl")
}
library(Rcompression)
sipi <- getBinaryURL("http://sipi.usc.edu/database/misc.zip")
con <- file("misc.zip","wb")
writeBin(sipi, con)
close(con)
unzip("misc.zip")
fz <- zipArchive("misc.zip")
names(fz)
img5 <- readImage(names(fz)[[5]])
display(img5, "Image from zip file")
