## Demo codes for p.22
rlogo <- readImage("http://www.r-project.org/Rlogo.jpg") 
display(rlogo)
writeImage(rlogo, "Rlogo.jpg")

## Demo codes for p.23 Fig.2.11
library(RgoogleMaps)
mapurl <- GetMap(c(37,138), 5, maptype="satellite", RETURNIMAGE=FALSE)
map <- readImage(mapurl)
mapgr <- channel(map, "gray")
display(mapgr)

## Demo codes for p.24
## Requires RCurl and Rcompression packages
## Rcompression is available only for R-2.13 or older
## See http://www.omegahat.org/Rcompression/ for details
library(RCurl)
library(Rcompression)
sipi <- getBinaryURL("http://sipi.usc.edu/database/misc.zip")
con <- file("misc.zip","wb")
writeBin(sipi, con)
close(con)
unzip("misc.zip")
fz <- zipArchive("misc.zip")
names(fz)
img5 <- readImage(names(fz)[[5]])
display(img5)