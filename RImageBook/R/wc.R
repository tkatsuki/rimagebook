wc <- function(signal, freq){
  if(!require(waveclock)){
    install.packages("waveclock")
    library("waveclock")
  }
  lt <- ts(signal, start = 0, freq = freq)
  pertab <- matrix(NA, ncol(lt), 2)

  for(i in 1:ncol(lt)) {
    clockresult <- waveclock(lt[,i], period = c(14, 34), 
                             cfamily.args = list(ptile = 0.005, bstep = 5, nbchain = 2000))
    if(is.null(clockresult$amp) == FALSE){
      per <- which.max(colMeans(clockresult$amp, na.rm = TRUE))
      period <- clockresult$modes[per,2]
      variance <- clockresult$modes[per,8]
      }else{
        period <- NA
        variance <- NA
        }
    pertab[i,] <- c(period, variance)
    }
  return(pertab)
  }
