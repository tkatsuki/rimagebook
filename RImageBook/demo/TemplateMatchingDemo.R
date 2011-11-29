## Demo for p.123 Fig.7.26
board <- readImage(system.file("images/board.jpg", package="RImageBook"))
display(board, "Target")
bat <- board[155:215, 250:315]
display(bat, "Template")
sad <- SAD(board, bat)
display(normalize(sad), "SAD")
minpeak <- which(sad==min(sad), arr.ind=TRUE)
minpeak
sadres <- board
sadres[(minpeak[1]-2):(minpeak[1]+nrow(bat)+1),
       (minpeak[2]-2):(minpeak[2]+ncol(bat)+1)] <- 1
sadres[(minpeak[1]):(minpeak[1]+nrow(bat)-1),
       (minpeak[2]):(minpeak[2]+ncol(bat)-1)] <- bat
display(sadres, "Detected position (SAD)")

## Demo for p.124
ncc <- NCC(board, bat)
display(ncc, "NCC")
maxpeak <- which(ncc==max(ncc),arr.ind=TRUE)

nccres <- board
nccres[(maxpeak[1]-nrow(bat)-2):(maxpeak[1]+1),
       (maxpeak[2]-ncol(bat)-2):(maxpeak[2]+1)] <- 1
nccres[(maxpeak[1]-nrow(bat)):(maxpeak[1]-1),
       (maxpeak[2]-ncol(bat)):(maxpeak[2]-1)] <- bat
display(nccres, "Detected position (NCC)")

## Demo for p.124
fncc <- FNCC(board, bat)
display(normalize(fncc), "FNCC")
maxpeak <- which(fncc==max(fncc),arr.ind=TRUE)
maxpeak
fnccres <- board
fnccres[(maxpeak[1]-2):(maxpeak[1]+nrow(bat)+1),
        (maxpeak[2]-2):(maxpeak[2]+ncol(bat)+1)] <- 1
fnccres[(maxpeak[1]):(maxpeak[1]+nrow(bat)-1),
        (maxpeak[2]):(maxpeak[2]+ncol(bat)-1)] <- bat
display(fnccres, "Detected position (FNCC)")

## Demo for p.125
system.time(sad <- SAD(board, bat))
system.time(ncc <- NCC(board, bat))
system.time(fncc <- FNCC(board, bat))
