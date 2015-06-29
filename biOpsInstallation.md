# biOpsのインストール方法 #
このページではRの画像処理パッケージの一つである[biOps](http://cran.r-project.org/web/packages/biOps/index.html)のインストール方法を説明します．基本的には通常のRのパッケージと同様にインストールできますが，OSによってはいくつかのライブラリを追加する必要があります．【追記】2014年現在biOpsはcranから入手できなくなっています．このためインストール方法を変更しました．

# Windows 32 bit #
  1. [jpeg62.dll](https://code.google.com/p/rimagebook/source/browse/jpeg62.dll)と[libtiff3.dll](https://code.google.com/p/rimagebook/source/browse/libtiff3.dll)と[libfftw3-3.dll](https://code.google.com/p/rimagebook/source/browse/libfftw3-3.dll)と[libfftw3f-f.dll](https://code.google.com/p/rimagebook/source/browse/libfftw3f-3.dll)と[libfftw3l-3.dll](https://code.google.com/p/rimagebook/source/browse/libfftw3l-3.dll)と[zlib1.dll](https://code.google.com/p/rimagebook/source/browse/zlib1.dll)をダウンロードし（各ファイルのページに移動してからView raw fileを右クリックして保存）、C:\Program Files\R\R-3.1.0\bin\i386 (バージョン番号は適宜変更)に置きます．各ファイルが数メガバイト以上あることを確認してください．
  1. [biOps\_0.2.2.zip](https://code.google.com/p/rimagebook/source/browse/biOps_0.2.2.zip)をダウンロードします．ファイルサイズが700KB程度であることを確認してください．
  1. Rを起動．
  1. PackagesメニューのInstall package(s)...を選択し、ダウンロードしたbiOps\_0.2.2.zipを選びます．
  1. 以下のコマンドでパッケージを読み込みます．
```
> library(biOps)
```
以上でbiOpsのインストールは完了です.

[RImageBookのインストールに戻る](RImageBookInstallation#Windows.md).

# Windows 64 bit #
  1. 注）このパッケージではbiOpsのjpegとtiffを読み書きする機能はサポートしません。
  1. [libfftw3-3.dll](https://code.google.com/p/rimagebook/source/browse/biOps_x64/libfftw3-3.dll)と[libfftw3f-f.dll](https://code.google.com/p/rimagebook/source/browse/biOps_x64/libfftw3f-3.dll)と[libfftw3l-3.dll](https://code.google.com/p/rimagebook/source/browse/biOps_x64/libfftw3l-3.dll)と[zlib1.dll](https://code.google.com/p/rimagebook/source/browse/zlib1.dll)をダウンロードし（各ファイルのページに移動してからView raw fileを右クリックして保存）、C:\Program Files\R\R-3.1.0\bin\x64 (バージョン番号は適宜変更)に置きます．各ファイルが数メガバイト以上あることを確認してください．
  1. [biOps\_0.2.2.zip](https://code.google.com/p/rimagebook/source/browse/biOps_x64/biOps_0.2.2.zip)をダウンロードします．ファイルサイズが700KB程度であることを確認してください．
  1. Rを起動．
  1. PackagesメニューのInstall package(s)...を選択し、ダウンロードしたbiOps\_0.2.2.zipを選びます．
  1. 以下のコマンドでパッケージを読み込みます．
```
> library(biOps)
```
以上でbiOpsのインストールは完了です.

[RImageBookのインストールに戻る](RImageBookInstallation#Windows.md).

# Linux #
Ubuntuを例に説明します．biOpsはlibfftw3とlibtiffとlibjpegに依存します．
  1. ターミナルで以下のコマンドを実行してライブラリをインストール．
```
$ sudo apt-get install libfftw3-dev libtiff4-dev libjpeg62-dev
```
  1. Rを起動してdevtoolsパッケージとbiOpsをインストールします．
```
$ sudo R
> install.packages("devtools")
> library(devtools)
> install_url("http://cran.r-project.org/src/contrib/Archive/biOps/biOps_0.2.2.tar.gz")
> library(biOps)
```
以上でbiOpsのインストールは完了です.

[RImageBookのインストールに戻る](RImageBookInstallation#Linux.md).

# Mac OS #
Leopard、Snow Leopard、Lionで共通です．
biOpsはlibfftw3とlibtiffとlibjpegに依存します．
  1. ターミナルで以下のコマンドを実行してライブラリをインストールします．
```
$ sudo port install fftw-3 tiff jpeg
```
  1. インストールしたライブラリにシンボリックリンクを張ります．
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
  1. RからdevtoolsパッケージとbiOpsをインストールします．
```
$ sudo R
> install.packages("devtools")
> library(devtools)
> install_url("http://cran.r-project.org/src/contrib/Archive/biOps/biOps_0.2.2.tar.gz")
> library(biOps)
```
以上でbiOpsのインストールは完了です.

[RImageBookのインストールに戻る](RImageBookInstallation#Mac_OS.md).