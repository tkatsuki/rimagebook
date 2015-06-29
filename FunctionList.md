# Rの画像処理関数 #



## 画像の表示 ##
|関数名 | 機能 | パッケージ名 |
|:---------|:-------|:-------------------|
|animate() |アニメーション表示（Windowsでは不可）|EBImage             |
|display() | 画像表示 | EBImage            |
|plot()    | 画像表示 |biOps               |
|image()   |グレースケール画像の疑似カラー表示 |graphics            |

## 画像の入力と保存 ##
|関数名 | 機能 | パッケージ名 |
|:---------|:-------|:-------------------|
|readImage() | 画像の入力(80種以上のファイル形式) | EBImage            |
|writeImage() | 画像の保存 | EBImage            |
|dicomSeparate()| DICOMファイルの入力 | oro.dicom          |
|readAVI() | 非圧縮AVIファイルの入力 | RImageBook         |
|readLsm() | lsm形式のファイルの入力 | RImageBook         |

## 画像データ型処理 ##
|関数名 | 機能 | パッケージ名 |
|:---------|:-------|:-------------------|
|as.Image() | Imageクラスオブジェクトに変換 | EBImage            |
|is.Image() | Imageクラスオブジェクトの検証 | EBImage            |
|imageData() | 画像データ型コンストラクタ | EBImage            |
|combine() | シリーズデータ作成 | EBImage            |
|imagedata()|imagedataクラスのデータを作成|biOps               |
|imageType()| imagedataクラスの色モードを検証 |biOps               |
|biOps2EBI() | imagedataクラスからImageクラスに変換 | RImageBook         |
|b2E()     | biOps2EBI()の短縮型 | RImageBook         |
|EBI2biOps() | Imageクラスからimagedataクラスに変換 | RImageBook         |
|E2b()     | EBI2biOps()の短縮型 | RImageBook         |
|imgconv() | ファイル形式の変換 | RImageBook         |

## 画像の変形・幾何学的変換 ##
|関数名 | 機能 | パッケージ名 |
|:---------|:-------|:-------------------|
|affine()  |アフィン変換|EBImage             |
|flip()    | x軸周りの鏡像変換 | EBImage            |
|flop()    | y軸周りの鏡像変換 | EBImage            |
|resize()  | 拡大・縮小 | EBImage            |
|rotate()  | 回転 | EBImage            |
|translate() | 平行移動 | EBImage            |
|imgCrop() | 画像の切り出し |biOps               |
|imgAverageShrink()|平均値による画像の縮小|biOps               |
|imgMedianShrink()|中央値による画像の縮小|biOps               |
|imgPadding()|画像のパディング|biOps               |
|imgRotate()|各種補間法による回転|biOps               |
|imgScale()|各種補間法による拡大|biOps               |
|imgRotate90Clockwise()|時計回りに90度の回転|biOps               |
|imgRotate90CounterClockwise()|反時計回りに90度の回転|biOps               |
|imgTranslate()|画像の一部を平行移動|biOps               |
|imgHorizontalMirroring()|y軸周りの鏡像変換|biOps               |
|imgVerticalMirroring()| x軸周りの鏡像変換|biOps               |
|niftyreg()|画像のレジストレーション|RNiftyReg           |
|skew()    | スキュー | RImageBook         |
|cropImage() | 画像の切り出し | RImageBook         |
|cropROI() | 対話的なROIの切り出し | RImageBook         |
|padding() | パディング | RImageBook         |
|pyramid() | 画像ピラミッドの作成 | RImageBook         |

## 空間フィルタ ##

|関数名 | 機能 | パッケージ名 |
|:---------|:-------|:-------------------|
|filter2() | 空間フィルタ | EBImage            |
|blur()    | ぼかし| EBImage            |
|gblur()   | ガウシアンブラ― | EBImage            |
|imgConvolve()|画像の畳み込み演算|biOpd               |
|imgBlockMedianFilter()|中央値フィルタ|biOps               |
|imgGaussianNoise()|画像にガウシアンノイズを加える|biOps               |
|imgSaltPepperNoise()|画像にゴマ塩ノイズを加える|biOps               |
|imgBlur() |ぼかし|biOps               |
|imgStdBlur()|ぼかし|biOps               |
|imgCanny()|エッジ検出|biOps               |
|imgDifferenceEdgeDetection()|エッジ検出|biOps               |
|imgFreiChen()|エッジ検出|biOps               |
|imgHomogeneityEdgeDetection()|エッジ検出|biOps               |
|imgKirsch()|エッジ検出|biOps               |
|imgMarrHildreth()|エッジ検出|biOps               |
|imgPrewitt()|Prewittフィルタによるエッジ検出|biOps               |
|imgPrewittCompassGradient()|エッジ検出|biOps               |
|imgRoberts()|エッジ検出|biOps               |
|imgRobinson3Level()|エッジ検出|biOps               |
|imgRobinson5Level()|エッジ検出|biOps               |
|imgShenCastan()|エッジ検出|biOps               |
|imgSobel()|エッジ検出|biOps               |
|imgBoost()|ハイブーストフィルタ|biOps               |
|imgHighPassFilter()|ハイパスフィルタ|biOps               |
|imgSharpen()|鮮鋭化|biOps               |
|imgUnsharpen()|鮮鋭化|biOps               |
|imgMaximumFilter()|最大値フィルタ|biOps               |
|imgMinimumFilter()|最小値フィルタ|biOps               |
|AnisotropicFilter() | 非等方拡散フィルタ | RImageBook         |
|GaussianKernel() | 2次元のガウシアンカーネルの作成 | RImageBook         |
|SpatialFilter2() | 空間フィルタ | RImageBook         |
|medianfilter() | 中央値フィルタ | RImageBook         |
|findPeaks() | 微分フィルタによるピーク検出 | RImageBook         |

## 周波数解析 ##
|関数名 | 機能 | パッケージ名 |
|:---------|:-------|:-------------------|
|imgFFT()  |離散フーリエ変換 |biOps               |
|imgFFTBandPass()|バンドパスフィルタ |biOps               |
|imgFFTBandStop()|バンドストップフィルタ |biOps               |
|imgFFTConvolve()|FFTを利用した畳み込み演算 |biOps               |
|imgFFTHighPass()|ハイパスフィルタ |biOps               |
|imgFFTInv()|離散フーリエ逆変換 |biOps               |
|imgFFTLowPass()|ローパスフィルタ |biOps               |
|imgFFTPhase()|位相情報の抽出 |biOps               |
|imgFFTShift()|行列のシフト |biOps               |
|imgFFTSpectrum()|振幅強度スペクトルの抽出 |biOps               |
|imgFFTiShift()|行列の逆シフト |biOps               |


## 色・階調変換 ##
|関数名 | 機能 | パッケージ名 |
|:---------|:-------|:-------------------|
|channel() | 色チャンネル変換 | EBImage            |
|equalize() | ヒストグラム平坦化 | EBImage            |
|normalize() | ヒストグラムの正規化 | EBImage            |
|rgbImage() | グレースケールからカラー画像の構成 | EBImage            |
|imgRedBand()|赤チャネルの抽出|biOps               |
|imgGreenBand()|緑チャネルの抽出|biOps               |
|imgBlueBand()|青チャネルの抽出|biOps               |
|imgGetRGBFromBands()|カラー画像の合成|biOps               |
|imgRGB2Grey()|グレースケール変換|biOps               |
|imgHistogram()|画像のヒストグラム|biOps               |
|imgIncreaseContrast()|コントラスト強調|biOps               |
|imgDecreaseContrast()|コントラストの減弱|biOps               |
|imgIncreaseIntensity()|明るさの強調|biOps               |
|imgDecreaseIntensity()|明るさの減弱|biOps               |
|imgGamma()|ガンマ補正|biOps               |
|imgNegative()|画像の階調反転|biOps               |
|imgNormalize()|階調の正規化|biOps               |
|imgEKMeans()|階調のクラスタリング|biOps               |
|imgIsoData()|階調のクラスタリング|biOps               |
|imgKDKMeans()|階調のクラスタリング|biOps               |
|imgKMeans()|階調のクラスタリング|biOps               |
|rgb2Gray() | グレースケール変換 | RImageBook         |
|pseudoColor() | 疑似カラー化 | RImageBook         |
|pseudoColor2() | 範囲指定でグレースケールを疑似カラー化 | RImageBook         |
|histogram() | 輝度値のヒストグラムを作成 | RImageBook         |
|whiteBalance() | 対話的なホワイトバランスの調整 | RImageBook         |
|subtractBg() | 対話的な背景補正 | RImageBook         |
|adjustContrast() | 対話的なコントラスト調整 | RImageBook         |
|measureArea() | 対話的なエリア測定 | RImageBook         |
|profileLine() | 対話的なプロファイル測定 | RImageBook         |

## 画像間演算 ##
|関数名 | 機能 | パッケージ名 |
|:---------|:-------|:-------------------|
|imgAND()  |AND     |biOps               |
|imgAdd()  |加算  |biOps               |
|imgAverage()|平均  |biOps               |
|imgDiffer()|差分  |biOps               |
|imgDivide()|除算  |biOps               |
|imgMultiply()|乗算  |biOps               |
|imgOR()   |OR      |biOps               |
|imgXOR()  |XOR     |biOps               |
|imgMaximum()|最大値|biOps               |
|emboss()  | エンボス加工 | RImageBook         |

## 基本図形描画 ##
|関数名 | 機能 | パッケージ名 |
|:---------|:-------|:-------------------|
|drawCircle() | 円描画 | EBImage            |
|drawfont() | フォント指定 | EBImage            |
|drawtext() | 画像へのテキスト描画 | EBImage            |
|paintObjects() | オブジェクトの描画 | EBImage            |
|rainbowBar() | 虹色の棒を描画 | RImageBook         |
|scaleBar() | スケールバーの描画 | RImageBook         |

## 2値画像の操作 ##
|関数名 | 機能 | パッケージ名 |
|:---------|:-------|:-------------------|
|thresh()  | 閾値処理 | EBImage            |
|closing() | クロージング | EBImage            |
|dilate()  |膨張  |EBImage             |
|distmap() | 背景ピクセルからの距離計算|EBImage             |
|erode()   |収縮  |EBImage             |
|fillHull() |オブジェクト内の穴を埋める |EBImage             |
|floodFill()|オブジェクトを埋める |EBImage             |
|makeBrush()|構造要素の作成 |EBImage             |
|opening() |オープニング |EBImage             |
|bwlabel() | バイナリセグメンテーション | EBImage            |
|propagate() | ボロノイ型セグメンテーション | EBImage            |
|reenumerate() | オブジェクトの再ラベリング | EBImage            |
|rmObjects() | オブジェクトの削除 | EBImage            |
|watershed() | 分水嶺型セグメンテーション | EBImage            |
|imgBinaryClosing()|クロージング|biOps               |
|imgBinaryDilation()|膨張  |biOps               |
|imgBinaryErosion()|収縮  |biOps               |
|imgBinaryOpening()|オープニング|biOps               |
|imgStdBinaryClosing()|クロージング|biOps               |
|imgStdBinaryDilation()|膨張  |biOps               |
|imgStdBinaryErosion()|収縮  |biOps               |
|imgStdBinaryOpening()|オープニング|biOps               |
|imgStdNDilationErosion()|N回の膨張と収縮|biOps               |
|imgStdNErosionDilation()|N回の収縮と膨張|biOps               |
|imgThreshold()|閾値処理|biOps               |

## 特徴抽出 ##
|関数名 | 機能 | パッケージ名 |
|:---------|:-------|:-------------------|
|computeFeatures()|特徴抽出 | EBImage            |
|computeFeatures.basic()|輝度に関する特徴抽出 | EBImage            |
|computeFeatures.moment|モーメントの算出 | EBImage            |
|computeFeatures.shape()|形態に関する特徴抽出 | EBImage            |
|computeFeatures.haralick()|テクスチャ抽出 | EBImage            |
|getFeatures() | 特徴抽出 | EBImage            |
|hullFeatures() |幾何学的な特徴抽出 | EBImage            |
|edgeProfile() |エッジプロファイルの抽出 | EBImage            |
|edgeFeatures() |エッジ特徴量の抽出 | EBImage            |
|ocontour() | 輪郭抽出 | EBImage            |
|cmomennts() |モーメントの算出 | EBImage            |
|smoments() |モーメントの算出 | EBImage            |
|rmoments() |モーメントの算出 | EBImage            |
|moments() |モーメントの算出 | EBImage            |
|zernikeMoments() | ツェルニケモーメントの算出 | EBImage            |
|haralickFeatures() |テクスチャ抽出 | EBImage            |
|haralickMatrix() |同時生起行列の算出 | EBImage            |
|skeletonize() | 骨格化 | RImageBook         |
|thinning() | 細線化 | RImageBook         |
|ending()  | 端点の検出 | RImageBook         |
|branch()  | 分岐点の検出 | RImageBook         |
|isolated() | 孤立点の検出 | RImageBook         |
|pruning() | ひげの剪定| RImageBook         |

## 3次元画像・動画像処理 ##
|関数名 | 機能 | パッケージ名 |
|:---------|:-------|:-------------------|
|stackObjects() | ラベル化されたオブジェクトをスタック化 | EBImage            |
|getNumberOfFrames() | フレーム数取得 | EBImage            |
|tile()    | スタック画像をタイル表示 | EBImage            |
|untile()  | 画像を分割してスタック画像に変換 | EBImage            |
|contour3d()|サーフェスレンダリング|misc3d              |
|VolumeRendering() | 3次元画像のボリュームレンダリング | RImageBook         |
|tracking() |軌跡の解析 |RImageBook          |
|trackDistance()|移動距離の算出|RImageBook          |
|trackSpeed()|移動の速さの算出|RImageBook          |
|angularVelocity()|角速度の算出|RImageBook          |
|msd()     |平均二乗変位の算出|RImageBook          |
|GoodFeaturesToTrack() | 特徴点検出 | RImageBook         |
|OpticalFlow() | オプティカルフローの検出 | RImageBook         |
|imgRowMaxs() | 最大値による投射 | RImageBook         |
|imgRowMins() | 最小値による投射 | RImageBook         |
|imgSD()   | 標準偏差による投射 | RImageBook         |
|medianPrj() | 中央値による投射 | RImageBook         |

## 画像認識 ##
|関数名 | 機能 | パッケージ名 |
|:---------|:-------|:-------------------|
|hough()   |ハフ変換による直線検出|PET                 |
|faceDetection() | 顔検出 | RImageBook         |
|FNCC()    | FFTによるテンプレートマッチング | RImageBook         |
|NCC()     | 相互相関によるテンプレートマッチング | RImageBook         |
|SAD()     | SADによるテンプレートマッチング| RImageBook         |