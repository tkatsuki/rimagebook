## Demo for p.71 Fig.4.24
engine <- readImage(system.file("images/engine.jpg", package="RImageBook"))
display(engine, "Original image")
engineem <- emboss(engine)
display(engineem, "Emboss")
