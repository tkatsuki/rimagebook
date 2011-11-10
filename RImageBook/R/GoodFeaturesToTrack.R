GoodFeaturesToTrack <- function(img, maxnum, quality=0.01, 
                                mindist=10, useHarris=0, subPix=0) {
  .Call("GoodFeaturesToTrack", img, as.integer(maxnum), 
        as.double(quality), as.double(mindist),
        as.integer(useHarris),as.integer(subPix))
}
