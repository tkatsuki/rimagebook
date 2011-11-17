w <- matrix(c(0, 0, 0, 0.8), 128, 128)
h <- matrix(c(0, 0, 0, 0, 0, 0, 0, 0.8), 128, 128)
h <- t(h)                       # 行列を転置
display(w)                      # 周期的な縦線
display(h)                      # wの2倍の周波数の横線
wbfft <- imgFFT(E2b(w))             # フーリエ変換
hbfft <- imgFFT(E2b(h))
wbspec <- imgFFTSpectrum(wbfft) # 周波数スペクトルの抽出
hbspec <- imgFFTSpectrum(hbfft)
display(b2E(wbspec))                    # 周波数スペクトルの表示
display(b2E(hbspec))


houses <- readImage(system.file("images/houses.png", package="RImageBook"))
housesb <- E2b(houses)
housesbfft <- imgFFT(housesb)   # 2次元離散フーリエ変換
str(housesbfft)
housesbffti <- imgFFTInv(housesbfft) # フーリエ逆変換
display(b2E(housesbffti))                    # フーリエ逆変換した画像の表示

housesbspec <- imgFFTSpectrum(housesbfft)  # 周波数スペクトルの抽出
display(b2E(housesbspec))

meanFilter <- matrix(1/25, 5, 5)           # 5x5の平均値フィルタの作成
housesm <- filter2(houses, meanFilter)     # 平均値フィルタの適用
gaussFilter <- GaussianKernel(11, 11, 1.8) # 11x11のガウシアンフィルタの作成
housesg <- filter2(houses, gaussFilter)    # ガウシアンフィルタの適用
housesmbf <- imgFFT(E2b(housesm))         # フーリエ変換
housesgbf <- imgFFT(E2b(housesg))
housesmbfspec <- imgFFTSpectrum(housesmbf) # 周波数スペクトルの抽出
housesgbfspec <- imgFFTSpectrum(housesgbf)
display(b2E(housesmbfspec))                       #　周波数スペクトルの表示
display(b2E(housesgbfspec))

houseslpf <- imgFFTLowPass(housesbfft, 50) # 半径50のローパスフィルタ
houseslps <- imgFFTSpectrum(houseslpf)     # 周波数スペクトルの抽出
houseslp <- imgFFTInv(houseslpf)           # フーリエ逆変換
display(b2E(houseslps))                            # 周波数スペクトルの表示
display(b2E(houseslp))

houseshpf <- imgFFTHighPass(housesbfft, 20) # 半径20のハイパスフィルタ
houseshps <- imgFFTSpectrum(houseshpf)      # 周波数スペクトルの抽出
houseshp <- imgFFTInv(houseshpf) 
display(b2E(houseshp))

housesbpf <- imgFFTBandPass(housesbfft, 20, 100) # バンドパスフィルタ
housesbps <- imgFFTSpectrum(housesbpf)           # 周波数スペクトルの抽出
housesbp <- imgFFTInv(housesbpf) 
display(b2E(housesbp))

w <- nrow(housesb)
h <- ncol(housesb)
gk <- GaussianKernel(w, h, 50)             # ガウス分布を作成
housesglf <- housesbfft * (gk/max(gk))     # ガウス分布型のローパスフィルタ
housesghf <- housesbfft * (1 - gk/max(gk)) # ガウス分布型のハイパスフィルタ
housesgls <- imgFFTSpectrum(housesglf)     # 周波数スペクトルの抽出
housesghs <- imgFFTSpectrum(housesghf)
housesgl <- imgFFTInv(housesglf)           # フーリエ逆変換
housesgh <- imgFFTInv(housesghf)
display(b2E(housesgl)); display(b2E(housesgh))
display(normalize(t(gk)))                  # フィルタの画像化
display(normalize(t(1-gk)))