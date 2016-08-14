#数据描述和分类汇总
vars <- c("mpg", "hp", "wt")
head(mtcars[vars])
summary(mtcars[vars])

# Listing 7.2 - descriptive stats via sapply()

mystats <- function(x, na.omit = FALSE) {
    if (na.omit) 
        x <- x[!is.na(x)]
    m <- mean(x)
    n <- length(x)
    s <- sd(x)
    skew <- sum((x - m)^3/s^3)/n
    kurt <- sum((x - m)^4/s^4)/n - 3
    return(c(n = n, mean = m, stdev = s, skew = skew, kurtosis = kurt))
}

sapply(mtcars[vars], mystats)
library(Hmisc)
describe(mtcars[vars])

library(pastecs)
stat.desc(mtcars[vars])

# Listing 7.5 - Descriptive statistics (psych package)

library(psych)
describe(mtcars[vars])

aggregate(mtcars[vars], by = list(am = mtcars$am), mean)
aggregate(mtcars[vars], by = list(am = mtcars$am), sd)

# Listing 7.7 - Descriptive statistics by group via by()

dstats <- function(x)(c(mean=mean(x), sd=sd(x)))
by(mtcars[vars], mtcars$am, dstats)

# Listing 7.8 Summary statists by group (doBy package)

library(doBy)
summaryBy(mpg + hp + wt ~ am, data = mtcars, FUN = mystats)

# Listing 7.9 - Summary statistics by group (psych package)

library(psych)
describe.by(mtcars[vars], mtcars$am)

# Listing 1.10 Summary statistics by group (reshape package)

library(reshape)
dstats <- function(x) (c(n = length(x), mean = mean(x), 
    sd = sd(x)))
dfm <- melt(mtcars, measure.vars = c("mpg", "hp", 
    "wt"), id.vars = c("am", "cyl"))
cast(dfm, am + cyl + variable ~ ., dstats)

###############################################
#离散型变量的数据描述
#离散型变量的数据描述，不管是有序还是无序 其数值的描述方式通常是一维列表和
#二维或多维交叉表，可用table() xtabs()完成； addmargins()用于增加不同维度的合计数
#sweep() prop.table()可将单元格的频数变为百分比
#ftable()可产生紧凑漂亮的描述表
library(vcd)
#table()多个一维数组的数据描述，把每列作为一个单独的变量，计数每行相同数值出现的次数
mytable <- with(Arthritis, table(Improved))
mytable
prop.table(mytable)
prop.table(mytable)*100


#xtabs()交叉列表，如果xtabs()函数中公式的左边有变量，那么它对应的就是
#表达式右侧分类变量不同水平组合的频数
mytable <- xtabs(~ Treatment+Improved, data=Arthritis)
mytable
#margin = NULL总百分比 单元格计数/总合计
#margin = 1 行百分比
#margin = 2 列百分比
margin.table(mytable,  margin = 1)
prop.table(mytable,  margin = 1)
margin.table(mytable, 2)
prop.table(mytable,  margin = 2)
prop.table(mytable)

#ftable()多维表的显示
head(mtcars)
ftable(gear + carb ~ vs + am, data = mtcars)
x <- ftable(mtcars[c("cyl", "vs", "am", "gear")])
x
# row.vars col.vars指定哪些变量应该出现在行上，哪些变量出现在列上
ftable(x, row.vars = c(2, 4))

ftable(mtcars$cyl, mtcars$vs, mtcars$am, mtcars$gear, row.vars = c(2, 4),
       dnn = c("Cylinders", "V/S", "Transmission", "Gears"))

#不同维度的合计
addmargins(mytable) 
admargins(prop.table(mytable))
##margin = 1增加1行表示列合计；margin = 2增加1列表示行合计
addmargins(prop.table(mytable, 1), margin = 2)
addmargins(prop.table(mytable, 2), margin = 1)

# Listing 7.11 - Two-way table using CrossTable

library(gmodels)
CrossTable(Arthritis$Treatment, Arthritis$Improved)

# Listing 7.12 - Three-way contingency table

mytable <- xtabs(~ Treatment+Sex+Improved, data=Arthritis)
mytable
ftable(mytable)
margin.table(mytable, 1)
margin.table(mytable, 2)
margin.table(mytable, 3)
margin.table(mytable, c(1,3))
ftable(prop.table(mytable, c(1, 2)))
ftable(addmargins(prop.table(mytable, c(1, 2)), 3))

gtable(addmargins(prop.table(mytable, c(1, 2)), 3)) * 100

# Listing 7.13 - Chis-square test of independence

library(vcd)
mytable <- xtabs(~Treatment+Improved, data=Arthritis)
chisq.test(mytable)
mytable <- xtabs(~Improved+Sex, data=Arthritis)
chisq.test(mytable)

# Fisher's exact test

mytable <- xtabs(~Treatment+Improved, data=Arthritis)
fisher.test(mytable)

# Chochran-Mantel-Haenszel test

mytable <- xtabs(~Treatment+Improved+Sex, data=Arthritis)
mantelhaen.test(mytable)

# Listing 7.14 - Measures of association for a two-way table

library(vcd)
mytable <- xtabs(~Treatment+Improved, data=Arthritis)
assocstats(mytable)

#########################################
#分类汇总
#1  针对列表数据的汇总
#对一维数组或列表元素进行分类汇总有lapply() sapply()（一维数组必须先转换为列表之后才能使用）
#lapply(X, FUN, ...)
#x要执行数据汇总的列表或一维数组名
#FUN数据汇总函数
x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE))
lapply(x, mean)
#查看每个数组数据的信息
sapply(x, class)

#对矩阵/数据表的分类汇总
rowSums() colSums() #行列合计
rowMeans() colMeans() #行列均值

#基于一维数组对单变量进行汇总
#根据某个分类变量的不同值，对其他变量进行操作，并且不同分类变量的取值不同
#变量汇总方式不同，
med.att <- apply(attitude, 2, median)
#data.matrix(attitude) 数据汇总对象
#MARGIN =2  1表示行 2表示列
#STATS对一维数组操作
#FUN汇总函数 = "+" "-" "*" "/"四种内置函数运算方式
#得到每一列的中位数，然后相应的列除以对应的中位数
sweep(data.matrix(attitude), MARGIN = 2, STATS = med.att, FUN = '/')

#sweep 只能得到一个结果，要想得到多个结果使用mapply()
#mapply()
mapply(function(x, y) seq_len(x) + y,
       c(a =  1, b = 2, c = 3),  # names from first
       c(A = 10, B = 0, C = -10))
word <- function(C, k) paste(rep.int(C, k), collapse = "")
mapply(word, LETTERS[1:6], 6:1, SIMPLIFY = FALSE)
##################################
# Listing 7.15 - converting a table into a flat file via table2flat

table2flat <- function(mytable) {
    df <- as.data.frame(mytable)
    rows <- dim(df)[1]
    cols <- dim(df)[2]
    x <- NULL
    for (i in 1:rows) {
        for (j in 1:df$Freq[i]) {
            row <- df[i, c(1:(cols - 1))]
            x <- rbind(x, row)
        }
    }
    row.names(x) <- c(1:dim(x)[1])
    return(x)
}

# Listing 7.16 - Using table2flat with published data

treatment <- rep(c("Placebo", "Treated"), 3)
improved <- rep(c("None", "Some", "Marked"), each = 2)
Freq <- c(29, 13, 7, 7, 7, 21)
mytable <- as.data.frame(cbind(treatment, improved, Freq))
mydata <- table2flat(mytable)
head(mydata)

# Listing 7.17 - Covariances and correlations

states <- state.x77[, 1:6]
cov(states)
cor(states)
cor(states, method="spearman")

x <- states[, c("Population", "Income", "Illiteracy", "HS Grad")]
y <- states[, c("Life Exp", "Murder")]
cor(x, y)

# partial correlation of population and murder rate, controlling
# for income, illiteracy rate, and HS graduation rate

library(ggm)
pcor(c(1, 5, 2, 3, 6), cov(states))

# Listing 7.18 - Testing correlations for significance

cor.test(states[, 3], states[, 5])

# Listing 7.19 - Correlation matrix and tests of significance via corr.test

library(psych)
corr.test(states, use = "complete")

# --Section 7.4--

# independent t-test

library(MASS)
t.test(Prob ~ So, data=UScrime)

# dependent t-test

library(MASS)
sapply(UScrime[c("U1", "U2")], function(x) (c(mean = mean(x), 
    sd = sd(x))))
with(UScrime, t.test(U1, U2, paired = TRUE))

# --Section 7.5--

# Wilcoxon two group comparison

with(UScrime, by(Prob, So, median))
wilcox.test(Prob ~ So, data=UScrime)
sapply(UScrime[c("U1", "U2")], median)
with(UScrime, wilcox.test(U1, U2, paired = TRUE))

# Kruskal Wallis test

states <- as.data.frame(cbind(state.region, state.x77))
kruskal.test(Illiteracy ~ state.region, data=states)

# Listing 7.20 - Nonparametric multiple comparisons

class <- state.region
var <- state.x77[, c("Illiteracy")]
mydata <- as.data.frame(cbind(class, var))
rm(class,var)
library(npmc)
summary(npmc(mydata), type = "BF")
#针对分组变量的数据汇总
#mydata 汇总数据
#by 用于分组汇总的分类变量，要求必须是列表
#FUN 汇总数据的函数
aggregate(mydata, by = list(mydata$class), median)
