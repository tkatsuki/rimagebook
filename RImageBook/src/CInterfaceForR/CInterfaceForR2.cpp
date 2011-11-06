#include "../ImageFilter/ImageFilter.h"
#include "R.h"
#include "Rinternals.h"

extern "C" {
 SEXP RWrapperMedianFilter(SEXP src, SEXP radius)
 {
  SEXP dst;
  SEXP dim = getAttrib(src,R_DimSymbol);
  if(isInteger(src)){
   PROTECT(dst = allocMatrix(INTSXP, INTEGER(dim)[0], INTEGER(dim)[1]));
   ImageFilter::MedianFilter(INTEGER(dst),INTEGER(src),
                             INTEGER(dim)[0],INTEGER(dim)[1],INTEGER(radius)[0]);
  } else {
   PROTECT(dst = allocMatrix(REALSXP, INTEGER(dim)[0], INTEGER(dim)[1]));
   ImageFilter::MedianFilter(REAL(dst),REAL(src),
                             INTEGER(dim)[0],INTEGER(dim)[1],INTEGER(radius)[0]);
  }
   UNPROTECT(1);
   return dst;
 }
}
