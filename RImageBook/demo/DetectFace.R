## Demo for p.168 Fig.11.8
## faceDetection() only available on Windows distribution
img <-readImage(system.file("images/lena.gif",package="EBImage"))
faces <- faceDetection(img, system.file("data/haarcascade_frontalface_alt.xml",package="RImageBook"))
face <- img
face[1:(faces[1,1]),] <- 0.2 * img[1:(faces[1,1]),]
face[(faces[1,1]+faces[3,1]):ncol(img),] <- 0.2 * img[(faces[1,1]+faces[3,1]):ncol(img),]
face[,1:(faces[2,1])] <- 0.2 * img[,1:(faces[2,1])]
face[,(faces[2,1]+faces[4,1]):nrow(img)] <- 0.2 * img[,(faces[2,1]+faces[4,1]):nrow(img)]
display(face, "Detected face")
