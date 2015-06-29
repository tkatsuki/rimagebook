# EBImageのインストール方法 #
**【重要】** EBImageは2012年の9月にバージョン4がリリースされました．以前のバージョンと比較すると様々な変更が加えられており，RImageBookの多くのデモがそのままでは動作しなくなりました．このため，本サイトではバージョン4になる前の最新版(3.12)のインストール方法を説明します．バージョン4を試したい方は[こちら](https://code.google.com/p/rimagebook/wiki/EBImage4)を参照してください．

EBImageは，いくつかの外部ライブラリを利用しているため，インストールに先立ってこれらのライブラリを用意する必要があります．基本的にはEBImageの[公式サイト](http://www.bioconductor.org/packages/devel/bioc/html/EBImage.html)（英語）に従えばよいですが，用いるライブラリのバージョンを間違えるとつまづくことがあるので注意してください．

# Windows #
EBImageをインストールする前に以下の3点を用意します．この際，ImageMagickとGTK+の\*バージョン**に気をつけます（注1）．
  * ImageMagick
  * GTK+
  * abindパッケージ**

  1. ImageMagickは[こちら](https://rimagebook.googlecode.com/files/ImageMagick-6.7.6-9-Q16-windows-dll.exe)からImageMagick-6.7.6-9-Q16-windows-dll.exeをダウンロードしてインストールしてください．インストールする際には，Add application directory to your system pathとInstall development headers and libraries for C and C++にチェックをいれます（下図参照）．![https://rimagebook.googlecode.com/svn/wiki/ImageMagick.png](https://rimagebook.googlecode.com/svn/wiki/ImageMagick.png)
  1. GTK+は最新バージョンではなく，少し古いバージョンを使います．[ここ](https://rimagebook.googlecode.com/files/gtk2-runtime-2.16.6-2010-05-12-ash.exe)からバージョン2.16のインストーラーを入手してインストールしてください．
  1. abindはRのパッケージなので，Rを起動して以下のコマンドでCRAN からインストールします．ダウンロードするミラーサーバを聞かれたら適当なサーバを選択します．
```
> install.packages("abind")
```
  1. 以上の3つのライブラリがそろったら，[ここから](http://www.bioconductor.org/packages/2.10/bioc/bin/windows/contrib/2.15/EBImage_3.12.0.zip)EBImageのバージョン3.12.0をダウンロードします．
  1. 「パッケージ」->「ローカルにあるzipファイルからのパッケージのインストール」からダウンロードしたEBImage\_3.12.0.zipを選択し，EBImageをインストールします．
![https://rimagebook.googlecode.com/svn/wiki/local.png](https://rimagebook.googlecode.com/svn/wiki/local.png)
  1. 以下のコマンドでEBImageを読み込みます．
```
> library(EBImage)
```
<a href='Hidden comment: 
# 以上の3つのライブラリがそろったら，Rで以下のコマンドを打ち，EBImageをインストールします．
```
> source("http://www.bioconductor.org/biocLite.R")
> biocLite("EBImage")
> library(EBImage)
```
'></a>

[biOpsのインストールに進む](https://code.google.com/p/rimagebook/wiki/biOpsInstallation#Windows)

注1: 最新バージョンのImageMagickでもEBImageはインストール可能ですが，readImage()関数でグレースケール画像を読み込んだ時にカラー画像と認識されるという不具合が発生します．その結果，いくつかのRImageBookのデモが正常に動作しません．また，6.6よりも古いバージョンのImageMagickを用いると，一部の関数（例えばresize関数）でRがクラッシュする問題が発生します．

# Linux #
Ubuntuを例に，LinuxにEBImageをインストールする方法を述べます．64 bitのアーキテクチャにも同じ方法でインストールできます．

  1. EBImageをインストールするために必要な外部ライブラリとしてpkg-configとImageMagickとgtk2を入手します．Ubuntuのバージョンによってはlibmagickwand-devがImageMagickのコアパッケージに含まれていないことがあるので，これも別途インストールします．
```
$ sudo apt-get install pkg-config
$ sudo apt-get install imagemagick
$ sudo apt-get install libmagickcore-dev
$ sudo apt-get install libmagickwand-dev
$ sudo apt-get install libgtk2.0-dev
$ sudo apt-get install gtk2-engines-pixbuf
```
  1. 以上のライブラリが正しくインストールされていることを下記のコマンドで確認します．エラーがでなければOKです．
```
$ pkg-config gtk+-2.0 --libs
$ Magick-config --libs
```
  1. Rのパッケージの一つであるabindをインストールします．Rを起動してinstall.packages()関数を使ってインストールします．ダウンロードするミラーサーバを聞かれたら適当なサーバを選択します．
```
$ sudo R
> install.packages("abind")
> library("abind")
```
  1. いったんRを終了し，次のコマンドでEBImageのダウンロードとインストールを行います．
```
$ sudo wget http://www.bioconductor.org/packages/2.10/bioc/src/contrib/EBImage_3.12.0.tar.gz
$ sudo R CMD INSTALL EBImage_3.12.0.tar.gz
```
  1. Rを起動して次のようにEBImageが読み込めればEBImageのインストールは完了です.
```
$ sudo R
> library(EBImage)
Loading required package: abind
```

[biOpsのインストールに進む](https://code.google.com/p/rimagebook/wiki/biOpsInstallation#Linux)

注: Ubuntuのバージョン(正確にはImageMagickのバージョン)によっては以下のようなエラーがでることがあります．
```
Error in dyn.load(file, DLLpath = DLLpath, ...) :
  unable to load shared object '/usr/local/lib/R/site-library/EBImage/libs/EBImage.so':
  libMagickCore.so.3: cannot open shared object file: No such file or directory
```
これは，新しいバージョンのImageMagickではlibMagickCore.so.3がlibMagickCore.so.4と変更されているためです（libMagickWand.so.3も同様）．この問題を解決するためには，例えば以下のようにシンボリックリンクを張ります．
```
sudo ln -s /usr/lib/libMagickWand.so.4 /usr/lib/libMagickWand.so.3
sudo ln -s /usr/lib/libMagickCore.so.4 /usr/lib/libMagickCore.so.3
```

# Mac OS #
OSのバージョンでインストール方法が異なるので，分けて説明します．

## Mac OS 10.7 (Lion) ##
以下の6点が必要になります．この方法でLionにインストールすると64 bitのアーキテクチャにインストールされます．
  * Xcode 4.2
  * MacPorts
  * XQuartz
  * ImageMagick
  * gtk+-2.0
  * abind

  1. XcodeはOSに付属のディスクからインストールするか，Appleの[Developerサイト](https://developer.apple.com/downloads/index.action)（要ユーザー登録），またはApp Storeから入手します．インストールしたら，ソフトウェアアップデートを実行してXcodeを更新しておきます．
  1. MacPortsは[ここ](http://www.macports.org/install.php)から最新版を入手します．
  1. XQuartzは[ここ](http://xquartz.macosforge.org/trac/wiki)から最新バージョンをダウンロードしてインストールします．XQuartzをインストールしたら再起動します．
  1. ImageMagickはターミナルを起動して以下のコマンドでインストールします．
```
$ sudo port install ImageMagick
```
  1. gtk+-2.0はターミナルから以下のコマンドでインストールします．
```
$ sudo port install gtk2
```
  1. ImageMagickとgtkが正しくインストールされていることを次のコマンドで確認します．
```
$ gtk-demo
$ convert -version
```
  1. abindをインストールします．abindはRのパッケージの一つなので，ターミナルでRを起動して以下のコマンドを実行します．ダウンロードするミラーサーバを聞かれたら適当なサーバを選択します．
```
$ sudo R
> install.packages("abind")
> library("abind")
```
  1. Xcode 4からはgcc-4.2とg++-4.2がなくなっているので，llvm-gcc-4.2とllvm-g++-4.2からシンボリックリンクを張ります．そのためにはターミナルで次のコマンドを実行します．
```
$ cd
$ sudo ln -s /usr/bin/llvm-gcc-4.2 /usr/bin/gcc-4.2
$ sudo ln -s /usr/bin/llvm-g++-4.2 /usr/bin/g++-4.2
```
  1. 以上でEBImageをインストールする準備が整ったので，ターミナルで次のようにしてダウンロードしインストールします．
```
$ sudo curl -O "http://www.bioconductor.org/packages/2.10/bioc/src/contrib/EBImage_3.12.0.tar.gz
"
$ sudo R CMD INSTALL EBImage_3.12.0.tar.gz
```
  1. Rを起動して次のようにEBImageを読み込むことができればEBImageのインストールは完了です.
```
$ sudo R
> library(EBImage)
Loading required package: abind
```

[biOpsのインストールに進む](https://code.google.com/p/rimagebook/wiki/biOpsInstallation#Mac_OS)


## Mac OS 10.6 (Snow Leopard) ##
以下の6点が必要になります．この方法でSnow Leopardにインストールすると64 bitのアーキテクチャにインストールされます．
  * Xcode 3.2
  * MacPorts
  * XQuartz
  * ImageMagick
  * gtk+-2.0
  * abind

  1. XcodeはOSに付属のディスクからインストールするか，Appleの[Developerサイト](https://developer.apple.com/downloads/index.action)から入手します（要ユーザー登録）．インストールしたら，ソフトウェアアップデートを実行してXcodeを更新しておきます．
  1. MacPortsは[ここ](http://www.macports.org/install.php)から最新版を入手します．
  1. XQuartzは[ここ](http://xquartz.macosforge.org/trac/wiki)から最新バージョンをダウンロードしてインストールします．XQuartzをインストールしたら再起動します．
  1. ImageMagickはターミナルを起動して以下のコマンドでインストールします．
```
$ sudo port install ImageMagick
```
  1. gtk+-2.0はターミナルから以下のコマンドでインストールします．
```
$ sudo port install gtk2
```
  1. ImageMagickとgtkが正しくインストールされていることを次のコマンドで確認します．
```
$ gtk-demo
$ convert -version
```
  1. abindをインストールします．abindはRのパッケージの一つなので，ターミナルでRを起動して以下のコマンドを実行します．ダウンロードするミラーサーバを聞かれたら適当なサーバを選択します．
```
$ sudo R
> install.packages("abind")
> library("abind")
```
  1. 以上でEBImageをインストールする準備が整ったので，ターミナルで次のようにしてダウンロードしインストールします．
```
$ sudo curl -O "http://www.bioconductor.org/packages/2.10/bioc/src/contrib/EBImage_3.12.0.tar.gz
"
$ sudo R CMD INSTALL EBImage_3.12.0.tar.gz
```
  1. Rを起動して次のようにEBImageを読み込むことができればEBImageのインストールは完了です.
```
$ sudo R
> library(EBImage)
Loading required package: abind
```

[biOpsのインストールに進む](https://code.google.com/p/rimagebook/wiki/biOpsInstallation#Mac_OS)

## Mac OS 10.5 (Leopard) ##
以下の7点が必要になります．この方法でLeopardにインストールすると32 bitのアーキテクチャにインストールされます．
  * Xcode 3.1
  * MacPorts
  * ImageMagick
  * gtk+-2.0
  * XQuartz
  * abind
  * tcltk

  1. XcodeはOSに付属のディスクからインストールするか，Appleの[Developerサイト](https://developer.apple.com/downloads/index.action)から入手します．
  1. MacPortsは[ここ](http://www.macports.org/install.php)から最新版を入手します．
  1. ImageMagickはターミナルから以下のコマンドでインストールします．
```
$ sudo port install ImageMagick
```
  1. gtk+-2.0はterminalから以下のコマンドでインストールします．
```
$ sudo port install gtk2
```
  1. XQuartzは[ここ](http://xquartz.macosforge.org/trac/wiki)から最新バージョンをダウンロードしてインストールします．
  1. gtkとImageMagickが正しくインストールされていることを次のコマンドで確認します．
```
$ gtk-demo
$ convert -version
```
  1. tcltkはRでinstall.packages()関数を用いるときにレポジトリを選択するウィンドウを開くために必要です．[ここ](http://cran.us.r-project.org/bin/macosx/tools/)からダウンロードしてインストールしておきます．
  1. abindはRのパッケージの一つなので，Rを起動して以下のコマンドでインストールします．ダウンロードするミラーサーバを聞かれたら適当なサーバを選択します．
```
$ sudo R
> install.packages("abind")
> library("abind")
```
  1. 以上でEBImageをインストールする準備が整ったので，ターミナルで次のようにしてダウンロードしインストールします．
```
$ sudo curl -O "http://www.bioconductor.org/packages/2.10/bioc/src/contrib/EBImage_3.12.0.tar.gz
"
$ sudo R CMD INSTALL EBImage_3.12.0.tar.gz
```
  1. Rを起動して次のようにEBImageが読み込めればEBImageのインストールは完了です.
```
$ sudo R
> library(EBImage)
Loading required package: abind
```

[biOpsのインストールに進む](https://code.google.com/p/rimagebook/wiki/biOpsInstallation#Mac_OS)