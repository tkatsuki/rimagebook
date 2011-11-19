## Demo for p.121 Fig.7.25
## Requires PET package
## install.packages("PET")
library(PET)
shapes <- readImage(system.file("images/shapes.png", package="EBImage"))
shapesr <- flip(shapes[151:500,1:350])
ThetaSamples <- 721 
rhosamples <- 2*round(sqrt(sum((dim(shapesr))^2))/2)+1
rhomin <- -0.5*((2*round(sqrt(sum((dim(shapesr))^2))/2)+1)-1)
drho <- (2*abs(rhomin)+1)/rhosamples
hb <- hough(shapesr,@ThetaSamples=ThetaSamples)
image(hb$hData, col=gray((0:32)/32), axes = FALSE, xlab="", ylab="")
peak <- which(hb$hData[]>(max(hb$hData[])*0.9), arr.ind=TRUE) 
windows()
image(1:nrow(shapesr), 1:ncol(shapesr), shapesr, 
      col = terrain.colors(100), axes = FALSE, xlab="", ylab="")
for (i in 1:nrow(peak)){
  the <- peak[i,1]*pi/ThetaSamples
  rho <- (peak[i,2]+rhomin)/drho
  curve(-(x-(nrow(shapesr)-1)*0.5)/tan(the)+rho/sin(the)+0.5*(ncol(shapesr)-1), 
         0, 350, xlab="", ylab="", xlim=c(0, 350), ylim=c(0, 350), add=TRUE)
} 