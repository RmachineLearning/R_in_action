
#K近邻
setwd("/media/zhoutao/软件盘/workspace/R/Data for An Introduction to Statistical Learning with Applications in R ")
#Data for An Introduction to Statistical Learning with Applications in R 书中的数据
#在 ISLR包中
#install.packages('ISLR') 

###1 收集数据
library(ISLR)
#查看变量名
names(Smarket) #Stock Market Data  股票数据
#查看数据类型
str(Smarket)
#查看前几排数据
head(Smarket)
#查看数据维度
dim(Smarket)
cor(Smarket)
attach(Smarket)
plot(Volume)

# 2 探索和准备数据
#把时间数值数据改为时间序列
library(zoo)
Smarket$Year = as.zoo(Smarket$Year)
#查看因子数据
table(Smarket$Direction)
#查看数值型数据
summary(Smarket[c("Lag1", "Lag2", "Lag3", "Lag4", "Lag5", "Volume", "Today")])
#数据标准化

#########################################################################
#######KNN
#install.packages("class")
#knn(class包)
library(class)

#1 选取训练集和测试集,两只股票Lag1 Lag2， Direction 股票上涨up 下降down
train = (Year < 2005)
Smarket .2005= Smarket [!train, ]
dim (Smarket.2005)
Direction.2005= Direction [!train] # 大于2005年的数据
train.X = cbind(Lag1, Lag2)[train, ]
test.X = cbind(Lag1, Lag2)[!train, ]

###KNN
#knn(train, test, class, k)
#train 一个包含数值型训练数据的数据框(注意是数值型数据)，
#test 一个包含数值型测试数据的数据框(数值型数据)
#class 训练数据每一行分类的因子向量
#k 标识最近邻数目的一个整数

#2 训练集的类别， knn预测测试集的类别
train.Direction = Direction[train]

#3 预测 测试集的类别
set.seed(1)
knn.pred = knn(train.X, test.X, train.Direction, k=1)
table(knn.pred) #计数 测试集est.X被分类的情况
#knn.pred包含的是test.X的预测分离(大于2005年)， Direction.2005真实的分类(大于2005年)
table(knn.pred, Direction.2005) # 统计错误率


#knn 3阶近邻
set.seed(1)
knn.pred = knn(train.X, test.X, train, train.Direction, k=3)

#4 评估模型的性能
table(knn.pred)
table(knn.pred, Direction.2005) # 统计正确和错误分类
mean(knn.pred == Direction.2005) # 计算正确预测分类率

#5 提高模型的性能
   #1 对数据进行标准化，等转换
   #2 测试其他的 k 值


