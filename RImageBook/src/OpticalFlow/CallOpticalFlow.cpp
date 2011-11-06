#include "OpticalFlow.h"
#include <vector>
#include <R.h>
#include <Rinternals.h>

// Rから呼ぶためのC言語関数ラッパ
extern "C" {
  // オプティカルフロー
  SEXP OpticalFlow(SEXP img0, SEXP img1, SEXP pos, SEXP winSize){
    int n = length(pos)/2;
    SEXP newpos;
    PROTECT(newpos = allocMatrix(REALSXP,4,n));

    SEXP dim = getAttrib(img0, R_DimSymbol);
    if(isInteger(img0)){
      OpticalFlowI32(INTEGER(img0), INTEGER(img1),
                     INTEGER(dim)[0], INTEGER(dim)[1],
                     REAL(pos), REAL(newpos), n, INTEGER(winSize)[0]);
    } else {
      OpticalFlowF64(REAL(img0), REAL(img1),
                     INTEGER(dim)[0], INTEGER(dim)[1],
                     REAL(pos), REAL(newpos), n, INTEGER(winSize)[0]);
    }
    UNPROTECT(1);
    return newpos;
  }

  // 特徴点取得
  SEXP GoodFeaturesToTrack(SEXP img, SEXP maxpos, SEXP quality, SEXP mindist, SEXP useHarris, SEXP subPix){
    SEXP dim = getAttrib(img, R_DimSymbol);
    int n;
    std::vector<double> pos(2*INTEGER(maxpos)[0]);
    if(isInteger(img)){
      n = GoodFeaturesToTrackI32(INTEGER(img),INTEGER(dim)[0],
                              INTEGER(dim)[1], INTEGER(maxpos)[0],
                              &pos[0], REAL(quality)[0], REAL(mindist)[0],
                              INTEGER(useHarris)[0],INTEGER(subPix)[0]);
    } else {
      n = GoodFeaturesToTrackF64(   REAL(img),INTEGER(dim)[0],
                              INTEGER(dim)[1], INTEGER(maxpos)[0],
                              &pos[0], REAL(quality)[0], REAL(mindist)[0],
                              INTEGER(useHarris)[0],INTEGER(subPix)[0]);
    }
    SEXP r;
    PROTECT(r = allocMatrix(REALSXP,2,n));
    std::copy(&pos[0],&pos[0]+2*n,REAL(r));
    UNPROTECT(1);
    return r;
  }
  
}
