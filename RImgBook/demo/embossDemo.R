engine <- readImage(system.file("images/engine.jpg", package="RImageBook"))
display(engine)
engineem <- emboss(engine)
display(engineem)