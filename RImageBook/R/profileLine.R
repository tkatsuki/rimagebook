profileLine <- function(img, n=2){
  if(!require(igraph)){
    install.packages("igraph")
    library("igraph")
  }
  ifelse(imageType(img)=="grey", img <- img, img <- imgRGB2Grey(img))
  plot(img)
  xy <- locator(n, type="l")
  xy <- lapply(xy, round)
  w <- ncol(img)
  h <- nrow(img)
  png(filename = "../../temp.png", width = w, height = h, bg = "black")
  par(plt=c(0, 1, 0, 1), xaxs="i", yaxs="i")
  plot(xy[[1]], xy[[2]], type="l", col="white", axes=F, xlim=c(0, w), ylim=c(0, h))
  dev.off()
  li <- readImage("../../temp.png")
  unlink("../../temp.png")
  
  imge <- biOps2EBI(img)
  x <- li@.Data
  skepx <- which(x==1, arr.ind=TRUE)
  skepxnm <- which(x==1) # for matching end points

  skepx.dist <- as.matrix(dist(skepx[,]))
  skepx.dist[which(skepx.dist[,] > 1.42)] <- 0
  g <- graph.adjacency(skepx.dist) # generate connection data

  start <- which(skepx[,1]==xy[[1]][1] & skepx[,2]==(h-xy[[2]][1]))
  end <- which(skepx[,1]==xy[[1]][n] & skepx[,2]==(h-xy[[2]][n]))

  ske.path <- get.shortest.paths(g, start-1, end-1)
  ske.path <- unlist(ske.path)
  ske.path.coord <- skepx[ske.path,]
  skenum <- ske.path.coord[,1] + (ske.path.coord[,2]-1)*nrow(x)    

  plot(imge[skenum]*255, type="l", ylab="Intensity", ylim=c(0, 255))
}