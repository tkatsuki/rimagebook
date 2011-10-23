faceDetection <- function(img, classifier, maxdetect = 10) {
  .Call("FaceDetect", arg1 = img, arg2 = nrow(img),
                      arg3 = ncol(img), arg4 = classifier, 
                      arg5 = as.integer(maxdetect))
}
