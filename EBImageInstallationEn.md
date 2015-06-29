# EBImage Installation Guide #
EBImage (**version <4.0**) depends on several external libraries, which need to be obtained before installing EBImage. Refer to the EBImage [development site](http://www.bioconductor.org/packages/devel/bioc/html/EBImage.html) for the official information. Note that correct version (not necessarily the latest version) of libraries need to be used.

# Windows #
EBImage requires the following three external components. Care must be taken for the **version** of ImageMagick and GTK+ (See **Note**).
  * ImageMagick
  * GTK+
  * abind (an R package)

  1. Download the specific version of ImageMagick (6.7.6-9) from [here](https://rimagebook.googlecode.com/files/ImageMagick-6.7.6-9-Q16-windows-dll.exe). During installation check "Add application directory to your system path" and "Install development headers and libraries for C and C++"(see figure below). ![https://rimagebook.googlecode.com/svn/wiki/ImageMagick.png](https://rimagebook.googlecode.com/svn/wiki/ImageMagick.png)
  1. Download GTK+ 2.16 from [here](https://rimagebook.googlecode.com/files/gtk2-runtime-2.16.6-2010-05-12-ash.exe). Newer versions are not compatible with EBImage.
  1. abind is an R package. To install, launch R and run the following command. If asked, choose appropriate mirror server.
```
> install.packages("abind")
```
  1. After installing those three libraries, download EBImage from [here](http://www.bioconductor.org/packages/2.10/bioc/bin/windows/contrib/2.15/EBImage_3.12.0.zip).
  1. Install the downloaded package from Packages->Install package(s) from local zip files (see the image below).
![https://rimagebook.googlecode.com/svn/wiki/local.png](https://rimagebook.googlecode.com/svn/wiki/local.png)
  1. Load EBImage.
```
> library(EBImage)
```

**Note**: The latest version of ImageMagick can be used to install EBImage, but it makes readImage() reads grayscale images as color images. As a consequence, some demos of RImageBook will not work as expected. If you use ImageMagick older than version 6.6, some functions of EBImage (e.g. resize()) does not work properly.

[Proceed to biOps installation](https://code.google.com/p/rimagebook/wiki/biOpsInstallationEn#Windows).

# Linux #
The following instruction describes how to install EBImage on Ubuntu Linux 32 bit or 64 bit.

  1. Obtain ImageMagick and gtk2. In some Ubuntu packages, ImageMagick does not include libmagickwand-dev, so you need to install this separately as follows.
```
$ sudo apt-get install pkg-config
$ sudo apt-get install imagemagick
$ sudo apt-get install libmagickcore-dev
$ sudo apt-get install libmagickwand-dev
$ sudo apt-get install libgtk2.0-dev
$ sudo apt-get install gtk2-engines-pixbuf
```
  1. Verify the packages you just installed.
```
$ pkg-config gtk+-2.0 --libs
$ Magick-config --libs
```
  1. Install abind, one of R packages, by using the install.packages() function in R. If asked, choose an appropriate mirror server.
```
$ sudo R
> install.packages("abind")
> library("abind")
```
  1. Close R. Then download and install EBImage with the following commands.
```
$ sudo wget http://www.bioconductor.org/packages/2.10/bioc/src/contrib/EBImage_3.12.0.tar.gz
$ sudo R CMD INSTALL EBImage_3.12.0.tar.gz
```
  1. Start R and load EBImage.
```
$ sudo R
> library(EBImage)
Loading required package: abind
```

Note: Depending on the version of Ubuntu (version of ImageMagick), you might see the following error:
```
Error in dyn.load(file, DLLpath = DLLpath, ...) :
  unable to load shared object '/usr/local/lib/R/site-library/EBImage/libs/EBImage.so':
  libMagickCore.so.3: cannot open shared object file: No such file or directory
```
This is due to the change of libMagickCore.so.3 to libMagickCore.so.4 (same for libMagickWand.so.3). A workaround is to set symbolic links with the following commands.
```
sudo ln -s /usr/lib/libMagickWand.so.4 /usr/lib/libMagickWand.so.3
sudo ln -s /usr/lib/libMagickCore.so.4 /usr/lib/libMagickCore.so.3
```

[Proceed to biOps installation](https://code.google.com/p/rimagebook/wiki/biOpsInstallationEn#Linux).

# Mac OS #
Different versions of Mac OS require different libraries.

## Mac OS 10.7 (Lion) ##
To install EBImage on Mac OS 10.7, you need following 6 components. The following instructions will install EBImage on a 64 bit architecture.
  * Xcode 4.2
  * MacPorts
  * XQuartz
  * ImageMagick
  * gtk+-2.0
  * abind

  1. Install Xcode from a disc that comes with the OS disc. Alternatively, you can download Xcode from Apple [Developer site](https://developer.apple.com/downloads/index.action)(registration required) or from App Store. After installing Xcode, make sure to run Software Update to update Xcode to the latest version.
  1. Obtain MacPorts from [here](http://www.macports.org/install.php).
  1. Obtain XQuartz from [here](http://xquartz.macosforge.org/trac/wiki). Restart computer after installing XQuartz.
  1. Install ImageMagick from Ternminal with the following command.
```
$ sudo port install ImageMagick
```
  1. Install gtk+-2.0 as well.
```
$ sudo port install gtk2
```
  1. Verify installation of ImageMagick and gtk.
```
$ gtk-demo
$ convert -version
```
  1. Install abind, one of R packages, by using the install.packages() function in R. If asked, choose an appropriate mirror server.
```
$ sudo R
> install.packages("abind")
> library("abind")
```
  1. Apple has removed gcc-4.2 and g++-4.2 from Xcode 4. Thus, you need to create symbolic links to llvm-gcc-4.2 and llvm-g++-4.2.
```
$ cd
$ sudo ln -s /usr/bin/llvm-gcc-4.2 /usr/bin/gcc-4.2
$ sudo ln -s /usr/bin/llvm-g++-4.2 /usr/bin/g++-4.2
```
  1. Now you are ready to install EBImage. Run the following commands in Terminal.
```
$ sudo curl -O "http://www.bioconductor.org/packages/2.10/bioc/src/contrib/EBImage_3.12.0.tar.gz"
$ sudo R CMD INSTALL EBImage_3.12.0.tar.gz
```
  1. Start R and load EBImage.
```
$ sudo R
> library(EBImage)
Loading required package: abind
```

[Proceed to biOps installation](https://code.google.com/p/rimagebook/wiki/biOpsInstallationEn#Mac_OS).


## Mac OS 10.6 (Snow Leopard) ##
To install EBImage on Mac OS 10.7, you need following 6 components. The following instructions will install EBImage on a 64 bit architecture.
  * Xcode 3.2
  * MacPorts
  * XQuartz
  * ImageMagick
  * gtk+-2.0
  * abind

  1. Install Xcode from a disc that comes with the OS disc. Alternatively, you can download Xcode from Apple [Developer site](https://developer.apple.com/downloads/index.action)(registration required) or from App Store. After installing Xcode, make sure to run Software Update to update Xcode to the latest version.
  1. Obtain MacPorts from [here](http://www.macports.org/install.php).
  1. Obtain XQuartz from [here](http://xquartz.macosforge.org/trac/wiki). Restart computer after installing XQuartz.
  1. Install ImageMagick from Ternminal with the following command.
```
$ sudo port install ImageMagick
```
  1. Install gtk+-2.0 as well.
```
$ sudo port install gtk2
```
  1. Verify installation of ImageMagick and gtk.
```
$ gtk-demo
$ convert -version
```
  1. Install abind, one of R packages, by using the install.packages() function in R. If asked, choose an appropriate mirror server.
```
$ sudo R
> install.packages("abind")
> library("abind")
```
  1. Now you are ready to install EBImage. Run the following commands in Terminal.
```
$ sudo curl -O "http://www.bioconductor.org/packages/2.10/bioc/src/contrib/EBImage_3.12.0.tar.gz"
$ sudo R CMD INSTALL EBImage_3.12.0.tar.gz
```
  1. Start R and load EBImage.
```
$ sudo R
> library(EBImage)
Loading required package: abind
```

[Proceed to biOps installation](https://code.google.com/p/rimagebook/wiki/biOpsInstallationEn#Mac_OS).

## Mac OS 10.5 (Leopard) ##
To install EBImage on Mac OS 10.5, you need following 7 components. The following instructions will install EBImage on a 32 bit architecture.
  * Xcode 3.1
  * MacPorts
  * ImageMagick
  * gtk+-2.0
  * XQuartz
  * abind
  * tcltk

  1. Install Xcode 3.1 from a disc that comes with the OS disc. Alternatively, you can download Xcode from Apple [Developer site](https://developer.apple.com/downloads/index.action)(registration required) or from App Store.
  1. Obtain MacPorts from [here](http://www.macports.org/install.php).
  1. Install ImageMagick by typing the following command in Terminal.
```
$ sudo port install ImageMagick
```
  1. Install gtk+-2.0.
```
$ sudo port install gtk2
```
  1. Obtain XQuartz from [here](http://xquartz.macosforge.org/trac/wiki).
  1. Verify gtk and ImageMagick installation.
```
$ gtk-demo
$ convert -version
```
  1. Install tcltk from [here](http://cran.us.r-project.org/bin/macosx/tools/).
  1. Install abind, one of R packages, by using the install.packages() function in R. If asked, choose an appropriate mirror server.
```
$ sudo R
> install.packages("abind")
> library("abind")
```
  1. Now you are ready to install EBImage. Run the following commands in Terminal.
```
$ sudo curl -O "http://www.bioconductor.org/packages/2.10/bioc/src/contrib/EBImage_3.12.0.tar.gz"
$ sudo R CMD INSTALL EBImage_3.12.0.tar.gz
```
  1. Start R and load EBImage.
```
$ sudo R
> library(EBImage)
Loading required package: abind
```

[Proceed to biOps installation](https://code.google.com/p/rimagebook/wiki/biOpsInstallationEn#Mac_OS).