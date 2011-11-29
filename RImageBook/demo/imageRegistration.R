## Demo for p.126 Fig.7.27
if(!require(RNiftyReg)){
  install.packages("RNiftyReg")
  library("RNiftyReg")
}
if(!require(bitops)){
  install.packages("bitops")
  library("bitops")
}
if(!require(oro.nifti)){
  install.packages("oro.nifti")
  library("oro.nifti")
}
chest <- readImage(system.file("images/chest.png", package="RImageBook"))
chesttr <- translate(chest, c(20,30))
chestrt <- EBImage::rotate(chest, 20)
chestzo <- resize(chest, nrow(chest)*1.1)
display(chest, "Original image")
display(chesttr, "Translated image")
display(chestrt, "Rotated image")
display(chestzo, "Zoomed image")
chestn <- as.nifti(imageData(chest))
chesttrn <- as.nifti(imageData(chesttr))
chestrtn <- as.nifti(imageData(chestrt))
chestzon <- as.nifti(imageData(chestzo))
trnreg <- niftyreg(chesttrn, chestn)
rtreg <- niftyreg(chestrtn, chestn, nLevels=5)
zoreg <- niftyreg(chestzon, chestn)
display(trnreg$image, "Translated image registered")
display(rtreg$image, "Rotated image registered")
display(zoreg$image, "Zoomed image registered")
decomposeAffine(trnreg$affine[[1]], chesttrn, chestn)
decomposeAffine(rtreg$affine[[1]], chestrtn, chestn)
decomposeAffine(zoreg$affine[[1]], chestzon, chestn)
