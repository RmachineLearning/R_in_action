#颜色包
#install.packages("RColorBrewer")
library(RColorBrewer)

#共有三组颜色可供使用：
#连续型Sequential：生成一系列连续渐变的颜色，通常用来标记连续型数值的大小。
#极端型Diverging：生成用深色强调两端、浅色标示中部的系列颜色，可用来标记数据中的离群点。
#离散型Qualitative：生成一系列彼此差异比较明显的颜色，通常用来标记分类数据。

#下面介绍这3套配色方案的用法。
#1）seq连续型：共18组颜色，每组分为9个渐变颜色展示。使用渐变色往往能让图形看起来更美观，避免单调的颜色在图形中显得突兀。实现代码如下：
display.brewer.all(type = "seq")
#如果想使用YlOrRd组的第3～8种颜色（）
#使用brewer.pal（9, "<某组渐变颜色的名称>"）来获取该组渐变色的全部9种颜色。
barplot(rep(1,6),col=brewer.pal(9, "YlOrRd")[3:8])
rand.data <- replicate(8,rnorm(100,100,sd=1.5))
boxplot(rand.data,col=brewer.pal(8,"Set3"))

#2）div极端型：共9组颜色，每组分为11个渐变颜色展示。其实现代码如下：
display.brewer.all(type = "div")
#如果想使用BrBG组的第3～8种颜色（），
#和seq连续型渐变色的使用不同，由于极端型中每组颜色分为11个渐变颜色，因此brewer.pal函数第一个参数不再是9，
#而是11，#即应使用brewer.pal （11, "<某组渐变颜色的名称>"）来读取该组渐变的11颜色。
barplot(rep(1,6),col=brewer.pal(11, "BrBG")[3:8])

#3）qual离散型：共8组颜色，每组渐变颜色数也不尽相同。其实现代码如下：
display.brewer.all(type = "qual")
#在该类型中，使用每组渐变色的方式与seq连续型和 div极端型类似：通过brewer.pal （n, "<某组渐变颜色的名称>"）
#语句可以读取该组内的n个渐变色（其中n是该组内渐变色的数目）。
#一般的绘图函数会使用col颜色参数。此外，一些元素还可以使用bg参数设置其背景颜色，
#使用border参数设置其边框颜色，其赋值和col参数一样。


#使用colorRampPalette可以扩展颜色。
newpalette<-colorRampPalette(brewer.pal(9,"Blues"))(10)
rand.data <- replicate(10,rnorm(100,100,sd=1.5))

boxplot(rand.data,col=newpalette)

