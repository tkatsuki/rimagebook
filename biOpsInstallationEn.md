# biOps Installation Guide #
This page describes how to install [biOps](http://cran.r-project.org/web/packages/biOps/index.html), an image processing package, on R. **Note**: As of 2014, biOps is no longer available from cran. The following instruction was updated to accommodate this change.

# Windows 32 bit #
  1. Download (go to the DLL's page then download the raw file) [jpeg62.dll](https://code.google.com/p/rimagebook/source/browse/jpeg62.dll), [libtiff3.dll](https://code.google.com/p/rimagebook/source/browse/libtiff3.dll), [libfftw3-3.dll](https://code.google.com/p/rimagebook/source/browse/libfftw3-3.dll), [libfftw3f-f.dll](https://code.google.com/p/rimagebook/source/browse/libfftw3f-3.dll), [libfftw3l-3.dll](https://code.google.com/p/rimagebook/source/browse/libfftw3l-3.dll), and [zlib1.dll](https://code.google.com/p/rimagebook/source/browse/zlib1.dll) to C:\Program Files\R\R-3.x.x\bin\i386 (x.x needs to be edited) or somewhere present in the PATH variables. Make sure that the downloaded dll files are MB in file size.
  1. Download [biOps\_0.2.2.zip](https://code.google.com/p/rimagebook/source/browse/biOps_0.2.2.zip) (go to the DLL's page then download the raw file). Make sure that the file size is around 700KB.
  1. Run 32 bit R.
  1. Choose biOps\_0.2.2.zip from Packages>Install package(s)...
  1. Load the library.
```
> library(biOps)
```

[Proceed to RImageBook installation](RImageBookInstallationEn#Windows.md).

# Windows 64 bit #
  1. Note: we dropped jpeg and tiff IO functions.
  1. Download (go to the DLL's page then download the raw file) [libfftw3-3.dll](https://code.google.com/p/rimagebook/source/browse/biOps_x64/libfftw3-3.dll), [libfftw3f-f.dll](https://code.google.com/p/rimagebook/source/browse/biOps_x64/libfftw3f-3.dll), [libfftw3l-3.dll](https://code.google.com/p/rimagebook/source/browse/biOps_x64/libfftw3l-3.dll), and [zlib1.dll](https://code.google.com/p/rimagebook/source/browse/zlib1.dll) to C:\Program Files\R\R-3.x.x\bin\x64 (x.x needs to be edited) or somewhere present in the PATH variables. Make sure that the downloaded dll files are MB in file size.
  1. Download [biOps\_0.2.2.zip](https://code.google.com/p/rimagebook/source/browse/biOps_x64/biOps_0.2.2.zip) (go to the DLL's page then download the raw file). Make sure that the file size is around 700KB.
  1. Run 64 bit R.
  1. Choose biOps\_0.2.2.zip from Packages>Install package(s)...
  1. Load the library.
```
> library(biOps)
```

[Proceed to RImageBook installation](RImageBookInstallationEn#Windows.md).


# Linux #
The following explanation is for Ubuntu Linux. biOps depends on libfftw3,libtiff, and libjpeg.
  1. Install there libraries by typing the following command in Terminal.
```
$ sudo apt-get install libfftw3-dev libtiff4-dev libjpeg62-dev
```
  1. Start R and install devtools and biOps.
```
$ sudo R
> install.packages("devtools")
> library(devtools)
> install_url("http://cran.r-project.org/src/contrib/Archive/biOps/biOps_0.2.2.tar.gz")
> library(biOps)
```


[Proceed to RImageBook installation](RImageBookInstallationEn#Linux.md).

# Mac OS #
This is for Leopard, Snow Leopard, and Lion.
biOps depends on libfftw3, libtiff, and libjpeg.
  1. Install these libraries by typing the following command in Terminal.
```
$ sudo port install fftw-3 tiff jpeg
```
  1. Create symbolic links to the libraries.
```
$ cd /usr/include
$ sudo ln -s /opt/local/include/fftw3.h
$ for x in /opt/local/include/j*.h; do sudo ln -s $x; done
$ for x in /opt/local/include/tiff*.h; do sudo ln -s $x; done
$ cd /usr/lib
$ for x in /opt/local/lib/libfftw3.*; do sudo ln -s $x; done
$ for x in /opt/local/lib/libjpeg.*; do sudo ln -s $x; done
$ for x in /opt/local/lib/libtiff.*; do sudo ln -s $x; done
```
  1. Start R and install devtools and biOps from the source file.
```
$ sudo R
> install.packages("devtools")
> library(devtools)
> install_url("http://cran.r-project.org/src/contrib/Archive/biOps/biOps_0.2.2.tar.gz")
> library(biOps)
```

[Proceed to RImageBook installation](RImageBookInstallationEn#Mac_OS.md).