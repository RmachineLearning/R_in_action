#plot.xts时间序列可视化
#让我有动力继续发现xts的强大。xts扩展了zoo的基础数据结构，并提供了更丰富的功能函数。
#xtsExtra补充库，从可视化的角度出发，提供了一个简单而效果非凡的作图函数plot.xts。
#本文将用plot.xts来演示，xts对象的时间序列可视化！

#1. xtsExtra包介绍
#xtsExtra是xts包的功能补充包，该软件包在Google Summer of Code 2012被开发，最终将合并到xts包。xtsExtra提供的主要功能就是plot.xts。

#注：我发现xts::plot.xts的函数，与xtsExtra::plot.xts还是有差别的。

#2. xtsExtra安装

#由于xtsExtra没有发布到CRAN，我们要从R-Forge下载。
install.packages("xtsExtra", repos="http://R-Forge.R-project.org")
#加载xtsExtra
library(xtsExtra)

#plot.xts函数被用来，覆盖xts::plot.xts函数。

################################################
#3. plot.xts的使用

#1). plot.xts的参数列表
#2). 简单的时间序列
#3). K线图
#4). panel配置
#5). screens配置
#6). events配置
#7). 双时间序列
#9). barplot

#1). plot.xts的参数列表
names(formals(plot.xts))

#2). 简单的时间序列
data(sample_matrix)
sample_xts <- as.xts(sample_matrix)
plot(sample_xts[,1]) 
class(sample_xts[,1])

#3). K线图 红白色
plot(sample_xts[1:30, ], type = "candles")

#自定义颜色
plot(sample_xts[1:30, ], type = "candles", bar.col.up = "blue", bar.col.dn = "violet", candle.col = "green4")


#4). panel配置
#基本面板
plot(sample_xts[,1:2])  

#多行面板
plot(sample_xts[,rep(1:4, each = 3)]) 

#自由组合面板
plot(sample_xts[,1:4], layout.screens = matrix(c(1,1,1,1,2,3,4,4),ncol = 2, byrow = TRUE))


#5). screens配置
#双屏幕显示，每屏幕2条线
plot(sample_xts, screens = 1:2) 
#双屏幕显示，指定曲线出现的屏幕和颜色
plot(sample_xts, screens = c(1,2,1,2), col = c(1,3,2,2))

#双屏幕显示，指定不同的坐标系
plot(10^sample_xts, screens = 1:2, log= c("","y"))


#双屏幕显示，指定不同的输出图形
plot(sample_xts[1:75,1:2] - 50.5, type = c("l","h"), lwd = c(1,2))
#多屏幕，分组显示
plot(sample_xts[,c(1:4, 3:4)], layout = matrix(c(1,1,1,1,2,2,3,4,5,6), ncol = 2, byrow = TRUE), yax.loc = "left")


#6). events配置

#基本事件分割线
plot(sample_xts[,1], events = list(time = c("2007-03-15","2007-05-01"), label = "bad days"), blocks = list(start.time = c("2007-03-05", "2007-04-15"), end.time = c("2007-03-20","2007-05-30"), col = c("lightblue1", "lightgreen")))


#7). 双时间序列
#
#双坐标视图
plot(sample_xts[,1],sample_xts[,2])

#双坐标梯度视图
cr <- colorRampPalette(c("#00FF00","#FF0000"))
plot(sample_xts[,1],sample_xts[,2], xy.labels = FALSE, xy.lines = TRUE, col = cr(NROW(sample_xts)), type = "l")


#8). xts类型转换作图
#ts类型作图
tser <- ts(cumsum(rnorm(50, 0.05, 0.15)), start = 2007, frequency = 12)
class(tser)
plot(tser)

#以xts类型作图
plot.xts(tser)

#9). barplot
x <- xts(matrix(abs(rnorm(72)), ncol = 6), Sys.Date() + 1:12)
colnames(x) <- LETTERS[1:6]
barplot(x)


