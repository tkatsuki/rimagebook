# RImageBook Installation Guide #
RImageBook provides utilities for digital image processing in R. It includes the functions described in the [book](http://www.amazon.co.jp/gp/product/4320019784/) as well as the scripts for reproducing the figures in the book．RImageBook depends on two other image processing packages, EBImage (**version <4**) and biOps. The following sections describe a step-by-step installation guide for Windows, Linux, and Mac OS. We thank [these people](AcknowledgementEN.md) for contributing to this document．

Here, the codes that start with "$" and ">" are Shell commands and R commands, respectively. You don't need to type $ or > when you run these commands.


# Windows #
Compatible with 32 bit Windows 7, XP, and Vista. Timing: 15 min.
  1. [Install R](RInstallationEn#Windows.md).
  1. [Install EBImage](https://code.google.com/p/rimagebook/wiki/EBImageInstallationEn#Windows).
  1. [Install biOps](https://code.google.com/p/rimagebook/wiki/biOpsInstallationEn#Windows).
  1. Launch R, and install RImageBook by running the following two commands:
```
> source("http://rimagebook.googlecode.com/svn/installRImageBook.R")
> installRImageBook()
```
  1. Load the package.
```
> library(RImageBook)
```
  1. Run some of the [demos](DemoListEn.md) to check functionality.
```
> demo(WingSegmentationDemo)
```

# Linux #
The following example is for Ubuntu Linux 32 bit and 64 bit. Timing: 10 min.

  1. [Install R](RInstallationEn#Linux.md).
  1. [Install EBImage](https://code.google.com/p/rimagebook/wiki/EBImageInstallationEn#Linux).
  1. [Install biOps](https://code.google.com/p/rimagebook/wiki/biOpsInstallationEn#Linux).
  1. Start R and install RImageBook with the following commands.
```
$ sudo R
> source("http://rimagebook.googlecode.com/svn/installRImageBook.R")
> installRImageBook()
```
  1. Load RImageBook package.
```
> library(RImageBook)
```
  1. Run a [demo](DemoListEn.md) to test the package.
```
> demo(WingSegmentationDemo)
```

  * **Note** If the steps above fail to install RImageBook, try checking out the package from our repository and build it yourself following the steps below.
```
$ sudo apt-get install subversion
$ sudo svn checkout http://rimagebook.googlecode.com/svn/trunk/ rimagebook-read-only
$ cd rimagebook-read-only/RImageBook
$ sudo bash ./build.sh
```

  * **Advanced** Installation of additional libraries (openCV and VTK) enables face recognition and volume rendering on R. Follow the instructions [here](BuildRimagebookOnLinuxEn.md).


# Mac OS #
Compatibility tested with Mac OS 10.5 Leopard, 10.6 Snow Leopard, and 10.7 Lion. Expect 2 to 4 hours to complete installation.
  1. [Install R](RInstallationEn#Mac_OS.md).
  1. [Install EBImage](https://code.google.com/p/rimagebook/wiki/EBImageInstallationEn#Mac_OS).
  1. [Install biOps](https://code.google.com/p/rimagebook/wiki/biOpsInstallationEn#Mac_OS)．
  1. Start R in Terminal and install RImageBook with the commands below.
```
$ sudo R
> source("http://rimagebook.googlecode.com/svn/installRImageBook.R")
> installRImageBook()
```
  1. Load RImageBook.
```
> library(RImageBook)
```
  1. Try some [demos](DemoList.md).
```
> demo(WingSegmentationDemo)
```

  * **Note** If the steps above fail to install RImageBook, try checking out the package from our repository and build it yourself following the steps below.
```
$ sudo svn checkout http://rimagebook.googlecode.com/svn/trunk/ rimagebook-read-only
$ cd rimagebook-read-only/RImageBook
$ sudo ./build.sh
```
  * **Advanced** Installation of additional libraries (openCV and VTK) enables face recognition and volume rendering on R. Follow the instructions [here](BuildRimagebookOnMacEn.md).