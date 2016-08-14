#规则学习
#规则学习类似与决策树， 代表if-else结构
setwd("/media/zhoutao/软件盘/workspace/R/Data for An Introduction to Statistical Learning with Applications in R ")

##1 收集数据
#mtcars {datasets}
data('iris')
str(iris)
dim(iris)

##2 探索和准备数据


#3 建立训练数据集 测试数据集
ind = order(runif(135, 0, 1)) #随机选择训练集
train_iris =  iris[ind, ]
test_iris = iris[-ind,]

##4 基于数据训练模型
#install.packages('RWeka')
library(RWeka)
#使用RWeka包中的1R算法OneR()函数
#OneR(class ~ predictors, data = mydata)
#class是mydata数据框中需要预测的那一列（因变量,分类变量， 不能用数值型变量）
#predictors 指定mydata数据框中用来预测的特征（自变量）

oner_iris = OneR(Species ~ ., data = train_iris)
oner_iris
#预测
p = predict(oner_iris, test_iris)

#4 评估模型的性能
summary(oner_iris)

#5 提高模型的性能
#使用JRip()函数，它是基于java实现的RIPPER规则学习算法，与1R算法一样，在RWeka包中
#m = JRip(class ~ predictors, data = mydata)
#同OneR参数同样的解释
#预测predict(m, test)
#JPoip允许它从所有的可用特征中选择规则
JRip_iris = JRip(Species ~ ., data = train_iris)
JRip_iris
summary(JRip_iris)











