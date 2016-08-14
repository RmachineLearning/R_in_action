
# Listing 4.1 - Creating the leadership data frame

manager <- c(1, 2, 3, 4, 5)
date <- c("10/24/08", "10/28/08", "10/1/08", "10/12/08", 
    "5/1/09")
gender <- c("M", "F", "F", "M", "F")
age <- c(32, 45, 25, 39, 99)
q1 <- c(5, 3, 3, 3, 2)
q2 <- c(4, 5, 5, 3, 2)
q3 <- c(5, 2, 5, 4, 1)
q4 <- c(5, 5, 5, NA, 2)
q5 <- c(5, 5, 2, NA, 1)

#stringsAsFactors = FALSE字符串不变成因子型
leadership <- data.frame(manager, date, gender, age, 
    q1, q2, q3, q4, q5, stringsAsFactors = FALSE)
str(leadership)    
# rm()删除变量
rm(manager, date, gender, age, q1, q2, q3, q4, q5)

############################################################
#将数值数据分类cut函数
#include.lowest = TRUE, rigth = FALSE 左开又闭
leadership$lei = cut(leadership$age , breaks = c(10,20,30,40,50,60,70,80,90,100), 
                     include.lowest = TRUE, rigth = FALSE)
leadership
leadership$lei2 = as.numeric(cut(leadership$age , breaks = c(10,20,30,40,50,60,70,80,90,100), 
                                 include.lowest = TRUE, rigth = FALSE))
leadership
#或者用car包中recode()函数
library(car)
leadership$lei3 = recode(leadership$age, "lo:30 = 1; 30:40 = 2; else = 3")
leadership

####################################################
#排序 sort(x) 等价于x[order(x)]， order默认升序(从小到大往下排)
sort(leadership$age)
leadership[order(leadership$age),]
#负号表示降序 
leadership[order(leadership$age, - q1),]
#rev()表示翻转
#对列翻转
leadership[, rev(1:ncol(leadership))]
#对行列同时翻转
leadership[rev(1:nrow(leadership)), rev(1:ncol(leadership))]
#################################################

#将多列数据叠成一列stack()
leadership_vec = stack(leadership, select = c(q1, q2, q3)) 
#将一列合成多列unstack() 或者split()
#ind 为分类依据的变量
leadership_vec2 = unstack(leadership_vec, value~ind)

#split将一列按类别转化为多个列表,drop= FALSE数据中不存在的水平也要保留，不能删除
mylist = split(leadership_vec$values, as.factor(leadership_vec$ind), drop= FALSE)
#将列表转化为数据框,首先将mylist用unlist转化为向量，然后转化为矩阵，再转化为数据框
mylist = data.frame(matrix(unlist(mylist), nrow = 3))


######################################################################
#选择部分观测值 subset, select 选择那些列， drop = FALSE为默认 返回结果为数据框
#否则返回列表
subset(leadership, q1 == 3, select = c("q1" , "q2", "age"), drop = FALSE)

#################################################################
#唯一与重复值查找, 
#duplicated 查找重复值， FALSE表示不是重复值（3第一次出现不是重复值，第二次出现才列为重复值）
duplicated(leadership$q1)
leadership[duplicated(leadership$q1), ] #查找 重复值

#唯一值 unique(), 返回的是q1中不重复的值
unique(leadership$q1)
unique(leadership[, c("q1", "q2")])
#########################################
##长型和宽型数据
#reshape()函数stats包中
#1 data 数据框，
#2 指定在转换中需要不同列变量的名字
#  idvar 指定研究对象，即被重复测量的对象
#  v.names 指定哪些变量由长型数据转变为宽型数据， 多个变量转换时，用c(“x1”,“x2”)指定
#  timevar 指定记录重复测量值的变量，默认将v.name 和timevar两个变量以点号连接
#
#3 direction = wide 或 long 长型数据转化为宽型数据，用wide
long.data = data.frame(subj = rep(1:4,each=3),  time = rep(1:3), 
                       x = rnorm(12), y=rnorm(12))

wide <- reshape(data = long.data, 
                v.names = c("x", "y"), 
                idvar = "subj",
                timevar = "time", 
                direction = "wide")
#以列表的形式查看宽型数据的属性
attributes(wide)
#将宽型数据恢复到原始的样子
long_data = reshape(wide)

#宽型转化为长型
#idvar 表示被重复观测的对象， varying以列表的形式指定需要转换的变量名，
#列表元素为同一对象不同测量值对应的变量名组成的一维数组
#idvar 研究对象的变量名，集被重复测量对象
#times 重复测量的时间变量的取值
#v.names 宽型数据转化为长型数据后新的变量名
#用new.row.name 参数改变输出数据框的行名称
widedata = data.frame(matrix(c(1:4, rnorm(24)), nrow = 4, byrow = FALSE))
colnames(widedata) = c("subj", "x1", "x2", "x3", "y1", "y2", "y3")

reshape(widedata, 
        idvar = "subj", 
        varying = list(c("x1", "x2", "x3"),c("y1", "y2", "y3")),
        v.names = c("x", "y"), 
        direction = "long",
        new.row.name = 1:12)



###############################################################
# 创建数据

mydata <- data.frame(x1 = c(2, 2, 6, 4), x2 = c(3, 
    4, 2, 8))
mydata$sumx <- mydata$x1 + mydata$x2
mydata$meanx <- (mydata$x1 + mydata$x2)/2

attach(mydata)
mydata$sumx <- x1 + x2
mydata$meanx <- (x1 + x2)/2
detach(mydata)

mydata <- transform(mydata, sumx = x1 + x2, meanx = (x1 + 
    x2)/2)

# --Section 4.3--

# Recoding variables

leadership$agecat[leadership$age > 75] <- "Elder"
leadership$agecat[leadership$age > 45 & 
    leadership$age <= 75] <- "Middle Aged"
leadership$agecat[leadership$age <= 45] <- "Young"

# or more compactly

leadership <- within(leadership, {
    agecat <- NA
    agecat[age > 75] <- "Elder"
    agecat[age >= 55 & age <= 75] <- "Middle Aged"
    agecat[age < 55] <- "Young"
})

# --Section 4.4--

library(reshape)

#使用reshape包实现长 宽型数据的转化
long.data = data.frame(subj = rep(1:4,each=3),  time = rep(1:3), 
                       x = rnorm(12), y=rnorm(12))
#中melt函数 将多列数据变成一列数据，id 作为索引，变成了长数据
stack.data = melt(long.data, id = c('subj', 'time'))
#cast转化为宽数据, 变量名变成了variable.time
wide.data = cast(subj~variable + time, data = stack.data)

#分组转化为宽数据, 以列表形式输出
wide.data2 = cast(subj~variable | time, data = stack.data)

#只保留部分转化的结果
wide.data3 = cast(subj~variable+time ,subset = variable =="x", data = stack.data)

#左侧为行变量，右侧为列变量，fun.aggregate 指定函数进行计算
wide.data4 = cast(subj  ~ variable ,fun.aggregate =mean, data = stack.data)
#以subj time指定行的唯一性，variable 为列的变量
wide.data4 = cast(subj+time  ~ variable ,fun.aggregate =mean, data = stack.data)

##重命名
rename(leadership, c(manager = "managerID", date = "testDate"))

# Applying the is.na() function 判断缺失值
is.na(leadership[, 6:10])

# recode 99 to missing for the variable age
leadership[leadership$age == 99, "age"] <- NA
leadership

# Using na.omit() to delete incomplete observations
newdata <- na.omit(leadership)
newdata


# Listing 4.7 - Using SQL statements to manipulate data frames

library(sqldf)
newdf <- sqldf("select * from mtcars where carb=1 order by mpg", 
    row.names = TRUE)
newdf <- sqldf("select avg(mpg) as avg_mpg, avg(disp) as avg_disp,
    gear from mtcars where cyl in (4, 6) group by gear")
    