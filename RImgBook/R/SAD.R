SAD <- function(trg, tmp){
  trg <- trg@.Data
  tmp <- tmp@.Data
  if(length(tmp) >= length(trg)) 
        stop("Template should be smaller than target.")
  w <- nrow(trg) - nrow(tmp) + 1
  h <- ncol(trg) - ncol(tmp) + 1
  SAD <- matrix(nrow=w, ncol=h)
  for (i in 1:w) for (j in 1:h){
    img_temp <- trg[i:(i+(nrow(tmp)-1)), j:(j+(ncol(tmp))-1)]
    SAD[i, j] <- sum(abs(img_temp-tmp))
    }
  return(SAD)
}