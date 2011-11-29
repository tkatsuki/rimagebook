## Demo for p.83 Fig.5.8
cassini <- readImage(system.file("images/cassini.jpg", package="RImageBook"))
lap4 <- matrix(c(0, 1, 0, 1, -4, 1, 0, 1, 0), 3, 3, byrow=TRUE)
caslap4 <- filter2(cassini, lap4)
display(cassini, "Original image")
display(cassini - 0.5*caslap4, "Edge enhancement")
display(cassini - 0.8*caslap4, "More enhancement")
display(cassini - caslap4, "Further enhancement")
