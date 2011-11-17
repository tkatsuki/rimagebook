chest <- readImage(system.file("images/chest.png", package="RImageBook"))
require(RNiftyReg)
require(bitops)
require(oro.nifti)
chesttr <- translate(chest, c(20,30)) # 平行移動
chestrt <- rotate(chest, 20) # 回転
chestzo <- resize(chest, nrow(chest)*1.1) # 拡大
display(chest)
display(chesttr)
display(chestrt)
display(chestzo)
chestn <- as.nifti(imageData(chest)) # nifti形式に変換
chesttrn <- as.nifti(imageData(chesttr))
chestrtn <- as.nifti(imageData(chestrt))
chestzon <- as.nifti(imageData(chestzo))
trnreg <- niftyreg(chesttrn, chestn) # レジストレーション処理
rtreg <- niftyreg(chestrtn, chestn, nLevels=5)
zoreg <- niftyreg(chestzon, chestn)
display(trnreg$image) # レジストレーションの結果を表示
display(rtreg$image)
display(zoreg$image)
decomposeAffine(trnreg$affine[[1]], chesttrn, chestn) # アフィン変換の解析
decomposeAffine(rtreg$affine[[1]], chestrtn, chestn)
decomposeAffine(zoreg$affine[[1]], chestzon, chestn)
