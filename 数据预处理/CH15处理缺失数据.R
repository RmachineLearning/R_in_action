#-------------------------------------------------------------#
# R in Action: Chapter 15                                     #
# requires that the VIM and mice packages have been installed #
# install.packages(c('VIM', 'mice'))                          #
#-------------------------------------------------------------#
#我们将学习处理缺失数据的传统方法和现代方法，主要使用VIM和mice包。命令
#install.packages(c("VIM","mice")) 可下载并安装这两个软件包。
#为了让讨论更有意思，我们将使用VIM包提供的哺乳动物睡眠数据（ sleep，注意不要将其
#与基础安装中描述药效的sleep数据集混淆）。

#################################################
数据说明：
数据来源于Allison和Chichetti（ 1976）的研究，他们研究了62种哺乳动物的睡眠、生态学变量和体质变量间的关系。他们对为什么动物的睡眠需求
会随着物种变化很感兴趣。
睡眠数据是因变量，生态学变量和体质变量是自变量或预测变量。
睡眠变量包含睡眠中做梦时长（ Dream）、不做梦的时长（ NonD）以及它们的和（ Sleep）。体
质变量包含体重（ BodyWgt，单位为千克）、脑重（ BrainWgt，单位为克）、寿命（ Span，单位为
年）和妊娠期（ Gest，单位为天）。生态学变量包含物种被捕食的程度（ Pred）、睡眠时暴露的程
度（ Exp）和面临的总危险度（ Danger）。生态学变量以从1（低）到5（高）的5分制进行测量。

一个完整的处理方法通常包含以下几个步骤：
(1) 识别缺失数据；
(2) 检查导致数据缺失的原因；
(3) 删除包含缺失值的实例或用合理的数值代替（插补）缺失值。

R使用NA（不可得）代表缺失值， NaN（不
是一个数）代表不可能的值。另外，符号Inf和-Inf分别代表正无穷和负无穷。函数is.na() 、
is.nan() 和is.infinite() 可分别用来识别缺失值、不可能值和无穷值。每个返回结果都是
TRUE或FALSE。
################################################
setwd('E:\\workspace\\R\\R in Action\\RiA Source Code')
# pause on each graph
par(ask = TRUE)

# load the dataset
data(sleep, package = "VIM")


# 函数complete.cases() 可用来识别矩阵或数据框中没有缺失值的行，
#若每行都包含完整的实例，则返回TRUE的逻辑向量；若每行有一个或多个缺失值，则返回FALSE。
#列出没有缺失值的行
sleep[complete.cases(sleep), ]

#列出有一个或多个缺失值的行
sleep[!complete.cases(sleep), ]

# 由于逻辑值TRUE和FALSE分别等价于数值1 和0，可用sum() 和mean() 函数来获取关于缺失数据的有用信息。
#结果表明变量Dream有12个缺失值， 19%的实例在此变量上有缺失值。另外，数据集中32%的实例包含一个或多个缺失值。
sum(is.na(sleep$Dream))
mean(is.na(sleep$Dream))
mean(!complete.cases(sleep))

对于识别缺失值，有两点需要牢记。第一点， complete.cases() 函数仅将NA和NaN识别为
缺失值，无穷值（ Inf和-Inf）被当做有效值。第二点，必须使用与本章中类似的缺失值函数来
识别R数据对象中的缺失值。像myvar == NA这样的逻辑比较无法实现。

#####################################################################
#15.3探索缺失值模式

#mice包中的md.pattern() 函数可生成一个以矩阵或数据框形式展示缺失值模式的表格
library(mice)
md.pattern(sleep)

# 图形探索缺失数据
#VIM包提供了大量能可视化数据集中缺失值模式的函数，本节我们将学习其中几个： aggr() 、matrixplot() 和scattMiss() 。
#VIM包有许多图形可以帮助你理解缺失数据在数据集中的模式，包括用散点图、箱线图、直方图、散点图矩阵、平行坐标图、轴须图和气泡图来展示缺失值的信息，因此这个包很值得探索。
library("VIM")
#aggr() 函数不仅绘制每个变量的缺失值数，还绘制每个变量组合的缺失值数
#选项numbers = FALSE（默认）删去数值型标签
aggr(sleep, prop = FALSE, numbers = TRUE)

#matrixplot() 函数可生成展示每个实例数据的图形
#数值型数据被重新转换到[0, 1]区间，并用灰度来表示大小：浅色表示值小，深色表示值大。默认缺失值为红色。
matrixplot(sleep) # use mouse to sort columns, STOP to move on
marginplot(sleep[c("Gest", "Dream")], pch = c(20), 
    col = c("darkgray", "red", "blue"))



# 15.3.3 用相关性探索缺失值
#指示变量替代数据集中的数据（ 1表示缺失，0表示存在），这样生成的矩阵有时称作影子矩阵。求这些指示变量间和它们与初始（可观测）变
#量间的相关性，有助于观察哪些变量常一起缺失，以及分析变量“缺失”与其他变量间的关系。
x <- as.data.frame(abs(is.na(sleep)))
head(sleep, n=5)
head(x, n=5)
y <- x[which(sd(x) > 0)]
cor(y)
cor(sleep, y, use = "pairwise.complete.obs")

# 15.6 完整实例分析（行删除）
cor(na.omit(sleep))
fit <- lm(Dream ~ Span + Gest, data = na.omit(sleep))
summary(fit)

# 15.7 多重插补
library(mice)
data(sleep, package = "VIM")
imp <- mice(sleep, seed = 1234)
fit <- with(imp, lm(Dream ~ Span + Gest))
pooled <- pool(fit)
summary(pooled)
imp
dataset3 <- complete(imp, action=3)
dataset3

#15.8.1  成对删除
cor(sleep, use="pairwise.complete.obs")
