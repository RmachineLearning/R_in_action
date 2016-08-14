##回归树和模型树，决策树的一种，用于数值型数据

#决策树用于数值预测(因变量为数值型数据而不是分类数据)可分为： 
#1 回归树CART算法
#2 模型树 M5算法

########################################

##1 收集数据
library(C50)
#C50包里面的数据
data(churn)
str(churnTrain)
class(churnTrain)
#移除对分类没由用的属性
churnTrain = churnTrain[,!names(churnTrain) %in% c("state",
                                                   "area_code", "account_length") ]

#2 探索和准备数据
str(churnTrain)
#查看因子数据
table(churnTrain$churn)
#查看数值型数据
summary(churnTrain[, -17])

#3 创建数据集， 测试集和训练集
#抽取训练集和测试集, 1 表示训练集， 2 表示测试集
ind = sample(2, nrow(churnTrain), replace = TRUE, prob=c(0.7, 0.3))
#去掉不用的第1和2列， 他们是因子变量
trainset = churnTrain[ind == 1,][-c(1,2)]
testset = churnTrain[ind == 2,][-c(1,2)]
names(trainset)
dim(trainset)
dim(testset)


#将回归加入到决策树，在包rpart中
#rpart(dv ~ iv, data=trainset)
#dv 因变量(可以是分类数据 可以是数值数据)(回归树最好用数值型数据作为因变量建模)
#iv 自变量

library(rpart)
churn.rp = rpart(churn ~ ., data=trainset)
#一共用2350个案例样本， 从根节点开始
#number_customer_service_calls>=3.5  有205个案例， 2350-205个案例小于这个数
#×表示的节点是终端或叶节点，
#那么 number_customer_service_calls>=3.5 并且total_day_minutes< 160.2 
#那么它的churn将预测为yes
churn.rp
printcp(churn.rp)

#检验复杂的参数
plotcp(churn.rp)
summary(churn.rp)
#可视化决策树
plot(churn.rp, margin= 0.1)
text(churn.rp, all=TRUE, use.n = TRUE)
plot(churn.rp, uniform=TRUE, branch=0.6, margin=0.1)
text(churn.rp, all=TRUE, use.n = TRUE)

#预测
pre_rpart = predict(churn.rp, testset, type="class")
table(testset$churn, pre_rpart)

#install.packages('caret')
library(caret)
confusionMatrix(table(testset$churn, pre_rpart))
#4 评估模型性能
summary(churn.rp)

#如果预测值是数值型数据，而不是分类数据，可以用
#cor(prediction, test_data) #预测数据和测试集数据的因变量
#或者像lm一样计算均方误差

##5 提升模型性能
##M5算法 在RWeka包中
library(RWeka)
#m.m5p = M5P(dv ~ vi , data = traindata)
#dv 因变量 vi  自变量
#预测
#predict(m.m5p, testdata)

str(DF3)
m3 <- M5P(churn ~ ., data=trainset)
m3
if(require("partykit", quietly = TRUE)) plot(m3)
summary(m3)
predict(m3, testset$churn)
summary(m3)
