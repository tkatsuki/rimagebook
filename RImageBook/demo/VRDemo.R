require("rgl")
require("misc3d")
require("AnalyzeFMRI")
a  <-  f.read.analyze.volume(system.file("example.img",  
                                         package="AnalyzeFMRI"))
a  <-  a[,,,1]
VolumeRendering(a,c(0,3000,8000,10000),
　　　　　　　　　　　　　　c(0,0,0,0,0.2,1,1,1,0.5,0,1,0,1,0,0,1),
　　　　　　　　　　　　　　Spacing=c(1.0,1.0,1.5))
