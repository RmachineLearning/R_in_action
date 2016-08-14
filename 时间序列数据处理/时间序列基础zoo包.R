3. zoo的API介绍

基础对象

zoo: 有序的时间序列对象
zooreg: 规则的的时间序列对象，继承zoo对象
类型转换

as.zoo: 把一个对象转型为zoo类型
plot.zoo: 为plot函数，提供zoo的接口
xyplot.zoo: 为lattice的xyplot函数，提供zoo的接口
ggplot2.zoo: 为ggplot2包，提供zoo的接口
数据操作

coredata: 获得和修改zoo的数据部分
index: 获得和修改zoo的索引部分
window.zoo: 按时间过滤数据
merge.zoo: 合并多个zoo对象
read.zoo: 从文件读写zoo序列
aggregate.zoo: 计算zoo数据
rollapply: 对zoo数据的滚动处理
rollmean: 对zoo数据的滚动，计算均值
NA值处理

na.?ll: NA值的填充
na.locf: 替换NA值
na.aggregate: 计算统计值替换NA值
na.approx: 计算插值替换NA值
na.StructTS: 计算seasonal Kalman filter替换NA值
na.trim: 过滤有NA的记录
辅助工具

is.regular: 检查是否是规则的序列
lag.zoo: 计算步长和分差
MATCH: 取交集
ORDER: 值排序，输出索引
显示控制

yearqtr: 以年季度显示时间
yearmon: 以年月显示时间
xblocks: 作图沿x轴分隔图型
make.par.list: 用于给plot.zoo 和 xyplot.zoo 数据格式转换
4. zoo使用

1). zoo函数
2). zooreg函数
3). zoo的类型转换
4). ggplot2画时间序列
5). 数据操作
6). 数据滚动处理
7). NA值处理
8). 数据显示格式
9). 按时间分隔做衅
10). 从文件读入zoo序列

##############################################################################
########1). zoo函数################

#zoo对象包括两部分组成，数据部分、索引部分。

#x: 数据部分，允许向量，矩阵，因子
#order.by: 索引部分，唯一字段，用于排序
#frequency: 每个时间单元显示的数量
zoo(x = NULL, order.by = index(x), frequency = NULL)


#构建一个zoo对象，以时间为索引

x.Date <- as.Date("2003-02-01") + c(1, 3, 7, 9, 14) - 1
class(x.Date)
x <- zoo(rnorm(5), x.Date)
class(x)
plot(x)


#以数学为索引的，多组时间序列
y <- zoo(matrix(1:12, 4, 3),0:30)
plot(y)


#######2). zooreg函数####################

#data: 数据部分，允许向量，矩阵，因子
#start: 时间部分，开始时间
#end: 时间部分，结束时间
#frequency: 每个时间单元显示的数量
#deltat: 连续观测之间的采样周期的几分之一，不能与frequency同时出现，例如1/2
#ts.eps: 时间序列间隔，在时间间隔大于ts.eps时认为是相等的。通过getOption(“ts.eps”)设置，默认是1e-05
#order.by: 索引部分，唯一字段，用于排序, 继承zoo的order.by

zooreg(data, start = 1, end = numeric(), frequency = 1,deltat = 1, ts.eps = getOption("ts.eps"), order.by = NULL)

构建一个zooreg对象
zooreg(1:10, frequency = 4, start = c(1959, 2))

as.zoo(ts(1:10, frequency = 4, start = c(1959, 2)))

zr<-zooreg(rnorm(10), frequency = 4, start = c(1959, 2))

plot(zr) 

###########3). zoo的类型转换###############
as.zoo(rnorm(5))

#从zoo类型转型到其他类型
x <- as.zoo(ts(rnorm(5), start = 1981, freq = 12))
as.matrix(x)
as.vector(x)
as.data.frame(x)
as.list(x)

##############4). ggplot2画时间序列###########
#ggplot2::fortify函数，通过zoo::ggplot2.zoo函数，转换成ggplot2可识别的类型。

library(ggplot2)
library(scales)

x.Date <- as.Date(paste(2003, 02, c(1, 3, 7, 9, 14), sep = "-"))
x <- zoo(rnorm(5), x.Date)
xlow <- x - runif(5)
xhigh <- x + runif(5)
z <- cbind(x, xlow, xhigh)

g<-ggplot(aes(x = Index, y = Value), data = fortify(x, melt = TRUE))
g<-g+geom_line()
g<-g+geom_line(aes(x = Index, y = xlow), colour = "red", data = fortify(xlow))
g<-g+geom_ribbon(aes(x = Index, y = x, ymin = xlow, ymax = xhigh), data = fortify(x), fill = "darkgray") 
g<-g+geom_line()
g<-g+xlab("Index") + ylab("x")
g

z

###############5). 数据操作#################
#修改zoo的数据部分coredata
x.date <- as.Date(paste(2003, rep(1:4, 4:1), seq(1,20,2), sep = "-"))
x <- zoo(matrix(rnorm(20), ncol = 2), x.date)
coredata(x)

#修改zoo的索引部分index


x.date <- as.Date(paste(2003, rep(1:4, 4:1), seq(1,20,2), sep = "-"))
x <- zoo(matrix(rnorm(20), ncol = 2), x.date)

index(x)


index(x) <- 1:nrow(x)
index(x)

#按时间过滤数据window.zoo


x.date <- as.Date(paste(2003, rep(1:4, 4:1), seq(1,20,2), sep = "-"))
x <- zoo(matrix(rnorm(20), ncol = 2), x.date)

window(x, start = as.Date("2003-02-01"), end = as.Date("2003-03-01"))


window(x, index = x.date[1:6], start = as.Date("2003-02-01"))

window(x, index = x.date[c(4, 8, 10)])

#合并多个zoo对象merge.zoo


y1 <- zoo(matrix(1:10, ncol = 2), 1:5)
y2 <- zoo(matrix(rnorm(10), ncol = 2), 3:7)

merge(y1, y2, all = FALSE)


merge(y1, y2, all = FALSE, suffixes = c("a", "b"))


merge(y1, y2, all = TRUE)


merge(y1, y2, all = TRUE, fill = 0)

#计算zoo数据aggregate.zoo


x.date <- as.Date(paste(2004, rep(1:4, 4:1), seq(1,20,2), sep = "-"))
x <- zoo(rnorm(12), x.date); x

 
x.date2 <- as.Date(paste(2004, rep(1:4, 4:1), 1, sep = "-")); x.date2


x2 <- aggregate(x, x.date2, mean); x2

######################6). 数据滚动处理##################

#对zoo数据的滚动处理rollapply


z <- zoo(11:15, as.Date(31:35))
rollapply(z, 2, mean)

#等价操作：rollapply ， aggregate


z2 <- zoo(rnorm(6))
rollapply(z2, 3, mean, by = 3) # means of nonoverlapping groups of 3

aggregate(z2, c(3,3,3,6,6,6), mean) # same

等价操作：rollapply， rollmean


rollapply(z2, 3, mean) # uses rollmean which is optimized for mean
         2          3          4          5 
-0.3065197 -0.7035811 -0.1672344  0.6350963 
rollmean(z2, 3) # same

##############################7). NA值处理####################
NA填充na.fill


z <- zoo(c(NA, 2, NA, 3, 4, 5, 9, NA))
z


na.fill(z, "extend")


na.fill(z, c("extend", NA))
 1  2  3  4  5  6  7  8 
 2  2 NA  3  4  5  9  9 

#直接用-1到-3进行填充
na.fill(z, -(1:3))
 1  2  3  4  5  6  7  8 
-1  2 -2  3  4  5  9 -3 
NA替换na.locf


z <- zoo(c(NA, 2, NA, 3, 4, 5, 9, NA, 11));z
 1  2  3  4  5  6  7  8  9 
NA  2 NA  3  4  5  9 NA 11 

na.locf(z)
 2  3  4  5  6  7  8  9 
 2  2  3  4  5  9  9 11 

na.locf(z, fromLast = TRUE)
 1  2  3  4  5  6  7  8  9 
 2  2  3  3  4  5  9 11 11 
统计值替换NA值na.aggregate


z <- zoo(c(1, NA, 3:9),
          c(as.Date("2010-01-01") + 0:2,
            as.Date("2010-02-01") + 0:2,
            as.Date("2011-01-01") + 0:2))
z
2010-01-01 2010-01-02 2010-01-03 2010-02-01 2010-02-02 2010-02-03 2011-01-01 
         1         NA          3          4          5          6          7 
2011-01-02 2011-01-03 
         8          9 

na.aggregate(z)
2010-01-01 2010-01-02 2010-01-03 2010-02-01 2010-02-02 2010-02-03 2011-01-01 
     1.000      5.375      3.000      4.000      5.000      6.000      7.000 
2011-01-02 2011-01-03 
     8.000      9.000 

na.aggregate(z, as.yearmon)
2010-01-01 2010-01-02 2010-01-03 2010-02-01 2010-02-02 2010-02-03 2011-01-01 
         1          2          3          4          5          6          7 
2011-01-02 2011-01-03 
         8          9 

na.aggregate(z, months)
2010-01-01 2010-01-02 2010-01-03 2010-02-01 2010-02-02 2010-02-03 2011-01-01 
       1.0        5.6        3.0        4.0        5.0        6.0        7.0 
2011-01-02 2011-01-03 
       8.0        9.0 

na.aggregate(z, format, "%Y")
2010-01-01 2010-01-02 2010-01-03 2010-02-01 2010-02-02 2010-02-03 2011-01-01 
       1.0        3.8        3.0        4.0        5.0        6.0        7.0 
2011-01-02 2011-01-03 
       8.0        9.0 
计算插值替换NA值


z <- zoo(c(2, NA, 1, 4, 5, 2), c(1, 3, 4, 6, 7, 8));z
 1  3  4  6  7  8 
 2 NA  1  4  5  2 

na.approx(z)
       1        3        4        6        7        8 
2.000000 1.333333 1.000000 4.000000 5.000000 2.000000 

na.approx(z, 1:6)
  1   3   4   6   7   8 
2.0 1.5 1.0 4.0 5.0 2.0 


#计算seasonal Kalman filter替换NA值


z <- zooreg(rep(10 * seq(4), each = 4) + rep(c(3, 1, 2, 4), times = 4),
            start = as.yearqtr(2000), freq = 4)
z[10] <- NA
zout <- na.StructTS(z);zout
plot(cbind(z, zout), screen = 1, col = 1:2, type = c("l", "p"), pch = 20)



















































