RImageBook package distributed from [Downloads](https://code.google.com/p/rimagebook/downloads/list) does not support functions such as face recognition, optical flow, and volume rendering, which depend on OpenCV and VTK. To enable these functions you need to build RImageBook on your computer by following the instructions below.

The following shell script includes all the procedures required to install R and other external libraries on MacOS 10.7 Lion and 10.6 Snow Leopard. It might be adapted to other distributions as well.

  * Installation script for MacOS 10.7 Lion and 10.6 Snow Leopard [InstallRImageBookMac64.sh](https://code.google.com/p/rimagebook/source/browse/InstallRImageBookMac64.sh)

If you are a user of MacOS 10.7 Lion or 10.6 Snow Leopard, you can build RImageBook that supports OpenCV and VTK by simply running the script after installing Xcode, MacPorts, and XQuartz. Installation might take a few hours.
```
$ sudo bash ./InstallRImageBookMac64.sh
```

Note that if you used the method above, you need to start R in the following way.
```
$ sudo env DYLD_LIBRARY_PATH=~/VTK/release/bin/ R
```

Below is the explanation of the script.

# Components reuired #
  * cmake
  * gcc
  * OpenCV source file
  * VTK source file

# OpenCV #
## Building OpenCV ##
  1. Uncompress OpenCV source file
```
    bzip2 -cd OpenCV-X.X.X.tar.bz2 | tar xvf -
```
  1. Create a directory for build files
```
    cd OpenCV-X.X.X
    mkdir release # any name is OK
    cd release
```
  1. Create Makefile
```
    cmake -D BUILD_SHARED_LIBS=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=${HOME}/usr/ ..
```
Note that ${HOME}/usr/ needs to be replaced according to your environment
  1. Build and install
```
    make; make install
```

# VTK #
## Required header and libraries ##
  * libglu-dev, libxt-dev, libosmesa-dev, etc.

## Building VTK ##
  1. Uncompress VTK and VTKData
```
    tar zxvf vtk-x.y.z.tar.gz
    tar zxvf vtkdata-x.y.z.tar.gz
```
  1. Create a directory for building
```
    cd VTK
    mkdir release
    cd release
```
  1. Create Makefile
```
    cmake -D BUILD_SHARED_LIBS=OFF -D CMAKE_BUILD_TYPE=Release \
          -D CMAKE_INSTALL_PREFIX=${HOME}/usr/ \
          -D VTK_DATA_ROOT=../../VTKData ..
```
  1. Build and install
```
    make; make install
```

# Modify RImageBook #
  1. Modify Makevars
> > Add paths to OpenCV and VTK libraries in Makevars.sample.
  1. Run build.sh