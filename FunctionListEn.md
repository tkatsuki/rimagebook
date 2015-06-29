# List of image processing functions in R #



## Displaying images ##
|Function name | Function | Package |
|:-------------|:---------|:--------|
|animate()     |Displaying animations (Not available for Windows)|EBImage  |
|display()     | Displaying images | EBImage |
|plot()        | Displaying images |biOps    |
|image()       |Pseudocolor representation of a grayscale image |graphics |

## Input and output ##
|Function name | Function | Package |
|:-------------|:---------|:--------|
|readImage()   | Reading images (over 80 different file types are supported) | EBImage |
|writeImage()  | Saving images | EBImage |
|dicomSeparate()| Reading DICOM files | oro.dicom|
|readAVI()     | Reading uncompressed AVI movies | RImageBook|
|readLsm()     | Reading uncompressed lsm files | RImageBook|

## Image type conversion ##
|Function name | Function | Package |
|:-------------|:---------|:--------|
|as.Image()    | Converting to an Image class object| EBImage |
|is.Image()    | Verifying Image class object | EBImage |
|imageData()   | Returning the array contained in an Image object | EBImage |
|combine()     | Concatenating images into series | EBImage |
|imagedata()   | Creating an imagedata class object|biOps    |
|imageType()   | Verifying imagedata class object |biOps    |
|biOps2EBI()   | Converting imagedata class to Image class | RImageBook|
|b2E()         | |Alias of biOps2EBI() | RImageBook|
|EBI2biOps()   | Converting Image class to imagedata class| RImageBook|
|E2b()         | Alias of EBI2biOps() | RImageBook|
|imgconv()     | Converting image file formats | RImageBook|

## Image transformation ##
|Function name | Effect | Package |
|:-------------|:-------|:--------|
|affine()      |Affine transformation|EBImage  |
|flip()        |  Vertical mirror image | EBImage |
|flop()        | Horizontal mirror image | EBImage |
|resize()      | Resizing | EBImage |
|rotate()      | Rotation | EBImage |
|translate()   | Translation | EBImage |
|imgCrop()     | Cropping |biOps    |
|imgAverageShrink()|Shrinking by averaging|biOps    |
|imgMedianShrink()|Shrinking by median|biOps    |
|imgPadding()  |Padding |biOps    |
|imgRotate()   |Rotation|biOps    |
|imgScale()    |Resizing|biOps    |
|imgRotate90Clockwise()|Rotating 90 degrees clockwise|biOps    |
|imgRotate90CounterClockwise()|Rotating 90 degrees counterclockwise|biOps    |
|imgTranslate()|Translating a part of image|biOps    |
|imgHorizontalMirroring()|Horizontal mirroring|biOps    |
|imgVerticalMirroring()| Vertical mirroring|biOps    |
|niftyreg()    |Image registration|RNiftyReg|
|skew()        | Skewing | RImageBook|
|cropImage()   | Cropping | RImageBook|
|cropROI()     | Cropping interactively | RImageBook|
|padding()     | Padding | RImageBook|
|pyramid()     | Creating an image pyramid | RImageBook|

## Spatial filtering ##

|Function name | Effect | Package |
|:-------------|:-------|:--------|
|filter2()     | Spatial filtering | EBImage |
|blur()        | Blurring| EBImage |
|gblur()       | Gaussian blurring | EBImage |
|imgConvolve() |Convolution|biOpd    |
|imgBlockMedianFilter()|Median filtering|biOps    |
|imgGaussianNoise()|Adding Gaussian noise|biOps    |
|imgSaltPepperNoise()|Adding salt and pepper noise|biOps    |
|imgBlur()     |Blurring|biOps    |
|imgStdBlur()  |Blurring|biOps    |
|imgCanny()    |Edge detection|biOps    |
|imgDifferenceEdgeDetection()|Edge detection|biOps    |
|imgFreiChen() |Edge detection|biOps    |
|imgHomogeneityEdgeDetection()|Edge detection|biOps    |
|imgKirsch()   |Edge detection|biOps    |
|imgMarrHildreth()|Edge detection|biOps    |
|imgPrewitt()  |Edge detection with Prewitt filter|biOps    |
|imgPrewittCompassGradient()|Edge detection|biOps    |
|imgRoberts()  |Edge detection|biOps    |
|imgRobinson3Level()|Edge detection|biOps    |
|imgRobinson5Level()|Edge detection|biOps    |
|imgShenCastan()|Edge detection|biOps    |
|imgSobel()    |Edge detection|biOps    |
|imgBoost()    |High-boost filtering|biOps    |
|imgHighPassFilter()|High-pass filtering|biOps    |
|imgSharpen()  |Sharpening|biOps    |
|imgUnsharpen()|Sharpening|biOps    |
|imgMaximumFilter()|Maximum filtering|biOps    |
|imgMinimumFilter()|Maximum filtering|biOps    |
|AnisotropicFilter() | Anisotropic filtering | RImageBook|
|GaussianKernel() | Creating 2D Gaussian kernel | RImageBook|
|SpatialFilter2() | Spatial filtering | RImageBook|
|medianfilter() | Median filtering | RImageBook|
|findPeaks()   | Peak finding | RImageBook|

## Frequency domain analysis ##
|Function name  | Effect | Package |
|:--------------|:-------|:--------|
|imgFFT()       |Fast Fourier Transform |biOps    |
|imgFFTBandPass()|Band-pass filter |biOps    |
|imgFFTBandStop()|Band-stop filter |biOps    |
|imgFFTConvolve()|Convolution using FFT |biOps    |
|imgFFTHighPass()|High-pass filter |biOps    |
|imgFFTInv()    |Inverse Fast Fourier Transform |biOps    |
|imgFFTLowPass()|Low-pass filter |biOps    |
|imgFFTPhase()  |Extract phase from a complex matrix |biOps    |
|imgFFTShift()  |Shifting a complex matrix |biOps    |
|imgFFTSpectrum()|Extract spectrum from a complex matrix |biOps    |
|imgFFTiShift() |Inverse shifting a complex matrix |biOps    |


## Color and gray level transformation ##
|Function name | Effect | Package |
|:-------------|:-------|:--------|
|channel()     | Color channel conversion | EBImage |
|equalize()    | Histogram equalization | EBImage |
|normalize()   | Histogram normalization | EBImage |
|rgbImage()    | Gray scale to color image conversion | EBImage |
|imgRedBand()  |Red channel extraction|biOps    |
|imgGreenBand()|Green channel extraction|biOps    |
|imgBlueBand() |Blue channel extraction|biOps    |
|imgGetRGBFromBands()|Create a color image|biOps    |
|imgRGB2Grey() |Grayscale conversion|biOps    |
|imgHistogram()|Image histogram|biOps    |
|imgIncreaseContrast()|Contrast enhancement|biOps    |
|imgDecreaseContrast()|Contrast reduction|biOps    |
|imgIncreaseIntensity()|Brightness enhancement|biOps    |
|imgDecreaseIntensity()|Brightness reduction|biOps    |
|imgGamma()    |Gamma correction|biOps    |
|imgNegative() |Image negation|biOps    |
|imgNormalize()|Histogram normalization|biOps    |
|imgEKMeans()  |biOps   | |
|imgIsoData()  |Image clustering|biOps    |
|imgKDKMeans() |Image clustering|biOps    |
|imgKMeans()   |Image clustering|biOps    |
|rgb2Gray()    | Grayscale conversion | RImageBook|
|pseudoColor() | Pseudo coloring | RImageBook|
|pseudoColor2() | Pseudo coloring in a specified range | RImageBook|
|histogram()   | Image histogram | RImageBook|
|whiteBalance() | Interactive white balance adjustment | RImageBook|
|subtractBg()  | Interactive background subtraction | RImageBook|
|adjustContrast() | Interactive contrast adjustment | RImageBook|
|measureArea() | Interactive area measurement | RImageBook|
|profileLine() | Interactive line profiling | RImageBook|

## Arithmetic operations ##
|Function name | Effect | Package |
|:-------------|:-------|:--------|
|imgAND()      |AND     |biOps    |
|imgAdd()      |Addition|biOps    |
|imgAverage()  |Averaging|biOps    |
|imgDiffer()   |Subtraction|biOps    |
|imgDivide()   |Division|biOps    |
|imgMultiply() |Multiplication|biOps    |
|imgOR()       |OR      |biOps    |
|imgXOR()      |XOR     |biOps    |
|imgMaximum()  |Maximum |biOps    |
|emboss()      | Embossing | RImageBook|

## Basic drawing functions ##
|Function name | Effect | Package |
|:-------------|:-------|:--------|
|drawCircle()  | Drawing a circle | EBImage |
|drawfont()    | Font setting | EBImage |
|drawtext()    | Drawing texts | EBImage |
|paintObjects() | Painting objects | EBImage |
|rainbowBar()  | Drawing a rainbow bar | RImageBook|
|scaleBar()    | Drawing a scale bar | RImageBook|

## Handling binary images ##
|Function name | Effect | Package |
|:-------------|:-------|:--------|
|thresh()      | Threshoulding | EBImage |
|closing()     | Closing | EBImage |
|dilate()      |Dilation |EBImage  |
|distmap()     | Distance map|EBImage  |
|erode()       |Erosion |EBImage  |
|fillHull()    |Filling holes in objects |EBImage  |
|floodFill()   |Filling an object |EBImage  |
|makeBrush()   |Creating a structural element |EBImage  |
|opening()     |Opening |EBImage  |
|bwlabel()     | Segmentation | EBImage |
|propagate()   | Voronoi-based segmentation | EBImage |
|reenumerate() | Reenumerating objects | EBImage |
|rmObjects()   | Removing objects | EBImage |
|watershed()   | Watershed-based segmentation | EBImage |
|imgBinaryClosing()|Closing |biOps    |
|imgBinaryDilation()|Dilation|biOps    |
|imgBinaryErosion()|Erosion |biOps    |
|imgBinaryOpening()|Opening |biOps    |
|imgStdBinaryClosing()|Closing grayscale image|biOps    |
|imgStdBinaryDilation()|Dilating grayscale image|biOps    |
|imgStdBinaryErosion()|Eroding grayscale image|biOps    |
|imgStdBinaryOpening()|Opening grayscale image|biOps    |
|imgStdNDilationErosion()|Dilating and erosing N times|biOps    |
|imgStdNErosionDilation()|Eroding and dilating N times|biOps    |
|imgThreshold()|Thresholding|biOps    |

## Feature extraction ##
|Function name | Effect | Package |
|:-------------|:-------|:--------|
|computeFeatures()|Feature extraction | EBImage |
|computeFeatures.basic()|Features about intensities | EBImage |
|computeFeatures.moment|Features about moments | EBImage |
|computeFeatures.shape()|Features about shapes | EBImage |
|computeFeatures.haralick()|Features about texture | EBImage |
|getFeatures() | Feature extraction | EBImage |
|hullFeatures() |Features about geometry  | EBImage |
|edgeProfile() |Edge profiles | EBImage |
|edgeFeatures() |Features about edges | EBImage |
|ocontour()    | Edge extraction | EBImage |
|cmomennts()   |Calculating moments | EBImage |
|smoments()    |Calculating moments| EBImage |
|rmoments()    |Calculating moments| EBImage |
|moments()     |Calculating moments| EBImage |
|zernikeMoments() | Calculating Zernike moments | EBImage |
|haralickFeatures() |Texture extraction | EBImage |
|haralickMatrix() |Calculating Haralick Matrix | EBImage |
|skeletonize() | Skeletonization | RImageBook|
|thinning()    | Thinning | RImageBook|
|ending()      | End point detection | RImageBook|
|branch()      | Branch detection | RImageBook|
|isolated()    | Detection of isolated points | RImageBook|
|pruning()     | Pruning| RImageBook|

## Handling 3D images and movies ##
|Function name | Effect | Package |
|:-------------|:-------|:--------|
|stackObjects() | Stacking labeled objects | EBImage |
|getNumberOfFrames() | Number of frames | EBImage |
|tile()        | Tiling an image stack| EBImage |
|untile()      | Stacking an image | EBImage |
|contour3d()   |Surface rendering|misc3d   |
|VolumeRendering() | Volume rendering | RImageBook|
|tracking()    |Object tracking |RImageBook |
|trackDistance()|Calculating track length|RImageBook|
|trackSpeed()  |Calculating object speed|RImageBook|
|angularVelocity()|Calculating angular velocity|RImageBook|
|msd()         |Calculating mean square deviation|RImageBook|
|GoodFeaturesToTrack() | Detecting features to track | RImageBook|
|OpticalFlow() | Optical flow | RImageBook|
|imgRowMaxs()  | Projection by maximum | RImageBook|
|imgRowMins()  | Projection by minimum | RImageBook|
|imgSD()       | Projection by standard deviation | RImageBook|
|medianPrj()   | Projection by median | RImageBook|

## Image recognition ##
|Function name | Effect | Package |
|:-------------|:-------|:--------|
|hough()       |Hough transformation|PET      |
|faceDetection() | Face detection | RImageBook|
|FNCC()        | Template matching by FFT | RImageBook|
|NCC()         | Template matching by normalized cross correlation | RImageBook|
|SAD()         | Template matching by sum of absolute differences| RImageBook|