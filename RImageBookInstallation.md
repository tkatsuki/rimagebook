# RImageBookのインストール方法 #
RImageBookは画像処理のためのRのパッケージです．[本書](http://www.amazon.co.jp/gp/product/4320019784/)で紹介した画像処理関数のほか，本書の図を再現するためのデモコードが含まれています．RImageBookをインストールするには，事前にEBImageとbiOpsというRのパッケージをインストールしておく必要があります（これらも画像処理用パッケージ）．以下，OSごとにインストールの手順を説明します．[謝辞](Acknowledgement.md)．

**【重要】** EBImageは2012年9月にバージョン4がリリースされました．以前のバージョンと比較すると様々な変更が加えられており，RImageBookの多くのデモがそのままでは動作しなくなりました．このため，本サイトではバージョン4になる前の最新版(3.12)のインストール方法を説明します．バージョン4を試してみたい方は[こちら](https://code.google.com/p/rimagebook/wiki/EBImage4)を参照してください．

説明の中で$から始まるコードはシェルのコマンドを表し，>から始まるコードはRのコマンドを表します（$や>を打ち込む必要はありません）．


# Windows #
Windows 7，XP，Vistaで動作を確認しています．32 bitのOSにのみ対応しています．15分程度の作業時間が見込まれます．
  1. [Rをインストール](RInstallation#Windows.md)．
  1. [EBImageをインストール](https://code.google.com/p/rimagebook/wiki/EBImageInstallation#Windows)．
  1. [biOpsをインストール](https://code.google.com/p/rimagebook/wiki/biOpsInstallation#Windows)．
  1. 以上の準備が完了したら，Rを起動してRImageBookをインストールします．
```
> source("http://rimagebook.googlecode.com/svn/installRImageBook.R")
> installRImageBook()
```
  1. パッケージをロードしてエラーが出なければOKです．
```
> library(RImageBook)
```
  1. 試しに[デモ](DemoList.md)を動作させてみましょう．
```
> demo(WingSegmentationDemo)
```

# Linux #
Ubuntuを例に説明します．32 bitと64 bitの両方に対応しています．10分程度の作業時間が見込まれます．

  1. [Rをインストール](RInstallation#Linux.md)
  1. [EBImageをインストール](https://code.google.com/p/rimagebook/wiki/EBImageInstallation#Linux)．
  1. [biOpsをインストール](https://code.google.com/p/rimagebook/wiki/biOpsInstallation#Linux)．
  1. 以上の準備が完了したら，Rを起動してRImageBookをインストールします．
```
$ sudo R
> source("http://rimagebook.googlecode.com/svn/installRImageBook.R")
> installRImageBook()
```
  1. パッケージをロードしてエラーが出なければOKです．
```
> library(RImageBook)
```
  1. 試しに[デモ](DemoList.md)を動作させてみましょう．
```
> demo(WingSegmentationDemo)
```

  * 【補足】以上の4から6のステップでRImageBookがうまくインストールされない場合は，リポジトリからチェックアウトしてお手元でパッケージをビルドしてみてください．
```
$ sudo apt-get install subversion
$ sudo svn checkout http://rimagebook.googlecode.com/svn/trunk/ rimagebook-read-only
$ cd rimagebook-read-only/RImageBook
$ sudo bash ./build.sh
```

  * 【発展】Linuxで顔認識やボリュームレンダリングを行うために必要な外部ライブラリ（openCVとVTK）のインストール方法は[こちら](BuildRimagebookOnLinux.md)です．


# Mac OS #
Mac OSの10.5 Leopardと10.6 Snow Leopardと10.7 Lionで動作を確認しています．2時間から4時間程度の作業時間が見込まれます．
  1. [Rをインストール](RInstallation#Mac_OS.md)
  1. [EBImageをインストール](https://code.google.com/p/rimagebook/wiki/EBImageInstallation#Mac_OS)．
  1. [biOpsをインストール](https://code.google.com/p/rimagebook/wiki/biOpsInstallation#Mac_OS)．
  1. 以上の準備が完了したら，ターミナルからRを起動してRImageBookをインストールします．
```
$ sudo R
> source("http://rimagebook.googlecode.com/svn/installRImageBook.R")
> installRImageBook()
```
  1. パッケージをロードしてエラーが出なければOKです．
```
> library(RImageBook)
```
  1. 試しに[デモ](DemoList.md)を動作させてみましょう．
```
> demo(WingSegmentationDemo)
```

  * 【補足】以上の4から6のステップでRImageBookがうまくインストールされない場合は，リポジトリからチェックアウトしてお手元でパッケージをビルドしてみてください．
```
$ sudo svn checkout http://rimagebook.googlecode.com/svn/trunk/ rimagebook-read-only
$ cd rimagebook-read-only/RImageBook
$ sudo ./build.sh
```
  * 【発展】Mac OSで顔認識やボリュームレンダリングを行うために必要な外部ライブラリ（openCVとVTK）のインストール方法は[こちら](BuildRimagebookOnMac.md)です．