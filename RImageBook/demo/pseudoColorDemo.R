nuclei <- readImage(system.file("images/nuclei.tif", package="EBImage"))
nuclei <- nuclei[,,1]
nucleipseudo <- pseudoColor(nuclei)
display(nucleipseudo)
nucleipseudo2 <- pseudoColor2(nuclei, 100, 255)
display(nucleipseudo2)