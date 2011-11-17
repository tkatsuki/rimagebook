require("rgl")
require("misc3d")
require("AnalyzeFMRI")
brain <- f.read.analyze.volume(system.file("example.img",  
                                           package="AnalyzeFMRI"))
brain <- brain[,,,1] # 4次元データの1フレーム目を取り出す
VolumeRendering(brain, c(0, 3000, 8000, 10000), 
                c(0,0,0,0, 0.2,1,1,1, 0.5,1,0,0, 1,0,1,0), 
                Spacing=c(1.0,1.0,1.5), RendererType=1)
