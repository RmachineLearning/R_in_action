#C50决策树
setwd("/media/zhoutao/软件盘/workspace/R/Data for An Introduction to Statistical Learning with Applications in R ")

#install.packages('C50')
library(C50)
#C50包里面的数据
data(churn)
str(churnTrain)
class(churnTrain)

#1 收集数据
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

#4 基于数据训练模型
#C5.O(train, class, trials = 1, costs = NULL)
#train 训练集 数据框
#class 训练集数据每一行的分类的一个因子变量
#trial 可选数值，控制自助法循环次数 默认为1
#costs 可选矩阵，该对象用于预测

#第17列是分类变量churn, 1和2 是没用到的因子分类变量
churn_C50 = C5.0(trainset[-17], trainset$churn, trails = 1, costs = NULL)
# 包含决策树 函数的调用，特征数(predictiors)和用决策树增长的方案(sample)
#列出树的大小Tree szie 2
churn_C50

#生出一个混淆矩阵，是一个交叉列表，表示模型对训练数据错误分类的记录数
#字段error 说明模型对除了训练集案例中，有0个案例被分类错误，错误率是0.0%，树的大小size是2
#共有359个案例被正确的划分为yes， 2002个案例被正确划分为no， 斜对角线为错误分类
summary(churn_C50)
#预测
#predict(m, test, type = 'class')
# test 是测试集数据框，
# type 取class 或prob 标识预测最可能的类别值或者原始的预测概率，返回一个向量
churn_C50_p = predict(churn_C50, testset, type = 'class')

#5 评估模型的性能
#install.packages('gmodels')
library(gmodels)
#参数依次为 测试集的分类变量， 测试集的预测值
#prop.c = FALSE prop.r = FALSE 删除行和列的百分比
#prop.t 表示剩余的百分比， 表示单元格中的记录数占总数记录数的百分比

#
CrossTable(testset$churn, churn_C50_p,
           prop.chisq = FALSE, 
           prop.r = FALSE, 
           prop.c = FALSE,
           dnn = c('actual', 'predicted'))

#6 提高模型的性能 
   #1 提高决策树的准确性 加入自适应增强算法(booting)到C50
   # trails = 10 在模型增强团队中使用独立决策树的数量, 迭代10次，进行减枝，使决策树变小
churn_C50_boot10 = C5.0(trainset[-17], trainset$churn, trails = 10, costs = NULL)
churn_C50_boot10
churn_C50_p_boot10 = predict(churn_C50_boot10, testset, type = 'class')
CrossTable(testset$churn, churn_C50_p_boot10,
           prop.chisq = FALSE, 
           prop.r = FALSE, 
           prop.c = FALSE,
           dnn = c('actual', 'predicted'))

   # 2为了防止决策树犯更严重的错误，C5.0允许我们将一个惩罚因子分配到不同类型的错误上，
#这些惩罚因子设定在一个代价矩阵中，用来制定每种错误相对于其他任何错误由多少倍的严重性

#行名中 1 代表 yes   2代表 no， 
erro_cost = matrix(c(0,1,4,0), nrow = 2)
churn_C50_boot10_err = C5.0(trainset[-17], trainset$churn, trails = 10, costs = erro_cost)
churn_C50_p_boot10_err = predict(churn_C50_boot10, testset, type = 'class')
CrossTable(testset$churn, churn_C50_p_boot10_erro,
           prop.chisq = FALSE, 
           prop.r = FALSE, 
           prop.c = FALSE,
           dnn = c('actual', 'predicted'))

h#