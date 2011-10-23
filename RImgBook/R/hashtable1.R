lut1 <- function(){
  # table for skeletonization() first round
  gr <- expand.grid(P2=c(1,0), P3=c(1,0), P4=c(1,0), P5=c(1,0), 
                    P6=c(1,0), P7=c(1,0), P8=c(1,0), P9=c(1,0))
  np <- c()
  tp <- c()
  P2P4P6 <- c()
  P4P6P8 <- c()
  val <- c()
  no <- c()
  nval <- c()
  
  for (i in 1:256){
    np[i] <- sum(gr[i, ])
    tp[i] <- 0
    P2P4P6[i] <- gr[i, 1]*gr[i, 3]*gr[i, 5]
    P4P6P8[i] <- gr[i, 3]*gr[i, 5]*gr[i, 7]
    for (j in 1:7){
      if((gr[i, (j+1)]-gr[i, j])==1){
        tp[i] <- tp[i]+1
      }
    }
    if((gr[i,1]-gr[i,8])==1){
      tp[i] <- tp[i]+1
    }
    ifelse ((np[i]>=2 & np[i]<=6 & tp[i]==1 & P2P4P6[i]==0 & P4P6P8[i]==0),
            val[i] <- 0, val[i]<-1)
    no[i] <- gr[i, 1]*2^0 + gr[i, 2]*2^1 + gr[i, 3]*2^2 + gr[i, 4]*2^3 + 
             gr[i, 5]*2^4 + gr[i, 6]*2^5 + gr[i, 7]*2^6 + gr[i, 8]*2^7
    nval[no[i]+1] <- val[i]
  }
  nval
}
