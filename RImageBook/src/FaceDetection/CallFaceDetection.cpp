#include "FaceDetection.h"
#include <vector>
#include <R.h>
#include <Rinternals.h>

// Rから呼ぶためのC言語関数ラッパー
extern "C" {
  SEXP FaceDetect(SEXP img, SEXP width, SEXP height, SEXP classifier, SEXP 
  maxdetect){
    std::vector<int> faces(4*INTEGER(maxdetect)[0]);
    int n;
    if(isInteger(img)){
     n = FaceDetectWrapperI32(INTEGER(img), INTEGER(width)[0], INTEGER(height)[0],
                CHAR(STRING_ELT(classifier,0)), &faces[0], INTEGER(maxdetect)[0]);
    } else {
     n = FaceDetectWrapperF64(   REAL(img),INTEGER(width)[0],INTEGER(height)[0],
                CHAR(STRING_ELT(classifier,0)), &faces[0], INTEGER(maxdetect)[0]);
    }
    SEXP r;
    if(n>0){
     PROTECT(r = allocMatrix(INTSXP,4,n));

      /* Rへのデータ引渡し (配列への変換) */
      for(size_t i=0;i<n;++i){
        INTEGER(r)[4*i+0] = faces[4*i+0];
        INTEGER(r)[4*i+1] = faces[4*i+1];
        INTEGER(r)[4*i+2] = faces[4*i+2];
        INTEGER(r)[4*i+3] = faces[4*i+3];
      }
     UNPROTECT(1);
    }
    return r;
  }
}
