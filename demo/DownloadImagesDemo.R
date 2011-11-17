                               # Rのロゴをダウンロード
rlogo <- readImage("http://www.r-project.org/Rlogo.jpg") 
display(rlogo)                 # ダウンロードしたロゴを表示
writeImage(rlogo, "Rlogo.jpg") # ロゴを保存

library(RCurl)
library(Rcompression)
                                  # バイナリデータをダウンロード
sipi <- getBinaryURL("http://sipi.usc.edu/database/misc.zip")
con <- file("misc.zip","wb")      # 保存先ファイルの準備
writeBin(sipi, con)               # ダウンロード済みのデータをファイルに書き出す
close(con)                        # ファイルを閉じて保存操作を完了する
unzip("misc.zip")                 # zipファイルを解凍
fz <- zipArchive("misc.zip")      # zipファイルの情報を取得
names(fz)                         # zipファイルに含まれるファイル名の表示
img5 <- readImage(names(fz)[[5]]) # ファイル名リストの5番目のファイルを取得
display(img5)

library(RgoogleMaps)
                              # 北緯37度東経138度の地図のURLを取得
mapurl <- GetMap(c(37,138), 5, maptype="satellite", RETURNIMAGE=FALSE)
map <- readImage(mapurl)      # 地図をダウンロード
mapgr <- channel(map, "gray") # 地図をグレースケールに変換
display(mapgr)                # 地図を表示 