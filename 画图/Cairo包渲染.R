#R语言的高质量图形渲染库Cairo
#1. Cairo介绍
#在信息领域中，cairo 是一个让用于提供矢量图形绘图的免费库，cairo 提供在多个背景下做 2D 的绘图，高级的更可以使用硬件加速功能。
#虽然 cairo 是使用C语言撰写的，但是当使用 cairo 时，可以用许多其他种语言来使用，包括有 C++、C#、Java、Python、Perl、Ruby、Scheme、Smalltalk 以及许多种语言，cairo 在 GNU LGPL 与 Mozilla Public License (MPL) 两个认证下发布。
#~ sudo apt-get install libcairo2-dev
#~ sudo apt-get install libxt-dev
setwd("/media/zhoutao/软件盘/workspace/R/R in Action/画图")
#install.packages("Cairo")

#3. Cairo使用

#Cairo使用起来非常简单，和基础包grDevices中的函数对应。

#CairoPNG: 对应grDevices:png()
#CairoJPEG: 对应grDevices:jpeg()
#CairoTIFF: 对应grDevices:tiff()
#CairoSVG: 对应grDevices:svg()
#CairoPDF: 对应grDevices:pdf()#
#我常用的图形输出，就是png和svg。
#检查Cairo的兼容性：
library(Cairo)
Cairo.capabilities()


#下面比较一下散点图的 CairoPNG() 和 png() 输出效果。
x<-rnorm(6000)
y<-rnorm(6000)

# PNG图
png(file="plot4.png",width=640,height=480)
plot(x,y,col="#ff000018",pch=19,cex=2,main = "plot")
dev.off()

CairoPNG(file="Cairo4.png",width=640,height=480)
plot(x,y,col="#ff000018",pch=19,cex=2,main = "Cairo")
dev.off()

# SVG图
svg(file="plot-svg4.svg",width=6,height=6)
plot(x,y,col="#ff000018",pch=19,cex=2,main = "plot-svg")
dev.off()

CairoSVG(file="Cairo-svg4.svg",width=6,height=6)
plot(x,y,col="#ff000018",pch=19,cex=2,main = "Cairo-svg")
dev.off()



#比较三维图的输出
x <- seq(-10, 10, length= 30)
y <- x
f <- function(x,y) { r <- sqrt(x^2+y^2); 10 * sin(r)/r }
z <- outer(x, y, f)
z[is.na(z)] <- 1

# PNG图
png(file="plot2.png",width=640,height=480)
op <- par(bg = "white", mar=c(0,2,3,0)+.1)
persp(x, y, z,
      theta = 30, phi = 30,
      expand = 0.5,
      col = "lightblue",
      ltheta = 120,
      shade = 0.75,
      ticktype = "detailed",
      xlab = "X", ylab = "Y", zlab = "Sinc(r)",
      main = "Plot"
)
par(op)
dev.off()

CairoPNG(file="Cairo2.png",width=640,height=480)
op <- par(bg = "white", mar=c(0,2,3,0)+.1)
persp(x, y, z,
      theta = 30, phi = 30,
      expand = 0.5,
      col = "lightblue",
      ltheta = 120,
      shade = 0.75,
      ticktype = "detailed",
      xlab = "X", ylab = "Y", zlab = "Sinc(r)",
      main = "Cairo"
)
par(op)
dev.off()


#3). 文字显示


library(MASS)
data(HairEyeColor)
x <- HairEyeColor[,,1]+HairEyeColor[,,2]

n <- 100
m <- matrix(sample(c(T,F),n^2,replace=T), nr=n, nc=n)

# PNG图
png(file="plot5.png",width=640,height=480)
biplot(corresp(m, nf=2), main="Plot")
dev.off()

CairoPNG(file="Cairo5.png",width=640,height=480)
biplot(corresp(m, nf=2), main="Cairo")
dev.off()

# SVG图
svg(file="plot-svg5.svg",width=6,height=6)
biplot(corresp(m, nf=2), main="Plot-svg")
dev.off()

CairoSVG(file="Cairo-svg5.svg",width=6,height=6)
biplot(corresp(m, nf=2), main="Cairo-svg")
dev.off()
