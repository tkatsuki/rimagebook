現在[ダウンロードリスト](https://code.google.com/p/rimagebook/downloads/list)から配布しているRImageBookのソースパッケージは，VTKとOpenCVをサポートしていません．このため，[RImageBookInstallation](RImageBookInstallation.md)に記した方法では顔認識，オプティカルフロー，ボリュームレンダリングといった機能が使えません．ここではコンパイルに関するある程度の知識を前提に，VTKとOpenCVをサポートしたRImageBookパッケージをビルドする方法を紹介します．

以下のシェルスクリプトは，MacOS 10.7 Lionおよび10.6 Snow Leopard上でRのインストールから外部ライブラリのインストールに至るまでのすべての手順を含んでいます．他のディストリビューションの方は環境に合わせて適宜変更してください．

  * MacOS 10.7 Lionおよび10.6 Snow Leopard用インストールスクリプト[InstallRImageBookMac64.sh](https://code.google.com/p/rimagebook/source/browse/InstallRImageBookMac64.sh)

MacOS 10.7 Lionまたは10.6 Snow Leopardをご利用の方は，XcodeとMacPortsとXQuartzをインストールした後に上記のスクリプトを実行すれば，OpenCVとVTKのライブラリをサポートしたRImageBookパッケージをインストールすることができます（インストールが完了するまでに数時間かかります）．
```
$ sudo bash ./InstallRImageBookMac64.sh
```

ただし，上記の方法を用いた場合，RImageBookを利用するためには，次のコマンドでRを起動しなければなりません．
```
$ sudo env DYLD_LIBRARY_PATH=~/VTK/release/bin/ R
```

以下にスクリプトの内容を解説します．

# 必要なもの #
  * cmake
  * gcc等
  * OpenCVのソース
  * VTKのソース

# OpenCV #
## ビルド手順 ##
  1. OpenCVのソースの展開
```
    bzip2 -cd OpenCV-X.X.X.tar.bz2 | tar xvf -
```
  1. ビルド用ディレクトリの作成
```
    cd OpenCV-X.X.X
    mkdir release #(名前はなんでもよい)
    cd release
```
  1. Makefileの作成
```
    cmake -D BUILD_SHARED_LIBS=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=${HOME}/usr/ ..
```
> ※${HOME}/usr/の部分はインストールしたいディレクトリに置き換える。
  1. ビルド・インストール
```
    make; make install
```

# VTK #
## 必要なライブラリ・ヘッダ ##
  * libglu-dev, libxt-dev, libosmesa-dev等

## ビルド手順 ##
  1. VTK, VTKDataの展開
```
    tar zxvf vtk-x.y.z.tar.gz
    tar zxvf vtkdata-x.y.z.tar.gz
```
  1. ビルド用ディレクトリの作成
```
    cd VTK
    mkdir release
    cd release
```
  1. Makefile生成
```
    cmake -D BUILD_SHARED_LIBS=OFF -D CMAKE_BUILD_TYPE=Release \
          -D CMAKE_INSTALL_PREFIX=${HOME}/usr/ \
          -D VTK_DATA_ROOT=../../VTKData ..
```
  1. ビルド・インストール
```
    make; make install
```

# RImageBook パッケージの修正 #
  1. Makevarsの修正
> > Makevars.sampleを編集し、OpenCV,VTKのヘッダファイル・ライブラリのパスを追加
  1. build.shの実行