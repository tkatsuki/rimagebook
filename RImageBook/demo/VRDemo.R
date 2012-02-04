## Demo for p.138 Fig.8.14
if(!require(rgl)){
  install.packages("rgl")
  library("rgl")
}
if(!require(misc3d)){
  install.packages("misc3d")
  library("misc3d")
}
if(!require(AnalyzeFMRI)){
  install.packages("AnalyzeFMRI")
  library("AnalyzeFMRI")
}
brain <- f.read.analyze.volume(system.file("example.img",  
                                           package="AnalyzeFMRI"))
brain <- brain[,,,1]
VolumeRendering(brain, c(0, 3000, 8000, 10000), 
                c(0,0,0,0, 0.2,1,1,1, 0.5,1,0,0, 1,0,1,0), 
                Spacing=c(1.0,1.0,1.5), RendererType=0)
