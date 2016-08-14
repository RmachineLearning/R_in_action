setwd("/media/zhoutao/软件盘/workspace/R/Data for An Introduction to Statistical Learning with Applications in R /提高模型性能")

#模型评价

##1 混淆矩阵：一张二维表，该表第一个维度表示所有可能的预测类别，第二维表示真实的类别
#正确的分类在对角线上，错误的在非对角线上，表中包含的是频数

#
#                预测 
#            否         是

#     否  TN(真阴)  FP(假阳)
#实际
#     是  FN(假阴)  TP(真阳)

#错误率 = FP + FN / TP + TN + FP + FN
#输出详细的混淆矩阵使用包gmodels中的CrossTable()函数
library(gmodels)
#CrossTable(result$actual_type, result$predict_type) 或者
data(infert, package = "datasets")
CrossTable(infert$education, infert$induced, expected = TRUE)

#caret包提供了机器学习模型和数据进行准备、训练、评估，以及可视化的工具
install.packages('caret')

#caret包提供了创建混淆矩阵的函数，类似table函数
library(caret)
library(MASS)
fit <- lda(Species ~ ., data = iris)
model <- predict(fit)$class

irisTabs <- table(model, iris$Species)

#输出混淆矩阵
confusionMatrix(irisTabs, positive = c('setosa', 'versicolor', 'virginica'))
CrossTable(irisTabs)

#1 kappa统计量
#kappa统计量（0,1）之间，小于0.2 很差的一致性，0.6-0.8 还行， 0.8-1 很好的一致性
#在CrossTable(xtab)例子中
# pr(a) = 0.672 + 0.157 也就是正确分类各自的频数除以 总频数 的和
# pr(e) = 0.765*0.750 + 0.157*0.235 每个类别真实概率乘以预测概率 然后对分类的乘积相加得到
#能够相加是因为两个事件是互斥的，简单的将两个概率相加得到任意一个事件发生的概率
#kappa = [pr(a) - pr(e)]/[1 - pr(e)]

#2 灵敏度与特异性
#灵敏度 = FP/(TP+FN) 度量阳性样本被正确分类的比例
#下面两个函数只能计算两个分类变量的统计值，如果是多个分类变了，则要取出两个分类变量计算
#positive 和negtive参数指定输入灵敏度 和特异性
specificity(irisTabs, c("setosa", "virginica"), positive = 'virginica')
sensitivity(irisTabs, "versicolor")
#特异性 = TN/（TN+FP） 度量阴性样本被正确分类的比例
specificity(irisTabs, c("setosa", "virginica"), negative = 'virginica')


#3 精准度和回溯精准度
#使用carte包中 posPredValue()计算精准度
posPredValue(irisTabs, c("setosa", "virginica"))
negPredValue(irisTabs, c("setosa", "virginica"))


###性能权衡的可视化
#install.packages('ROCR')
#ROCR包创建可视化图， 需要两个数据向量，一个必须包含预测的类别值 一个是包含阳性类别的估计概率
library(ROCR)
data(ROCR.simple)
pred <- prediction( ROCR.simple$predictions, ROCR.simple$labels)
#performance计算所有预测对象的性能度量值
perf <- performance(pred,"tpr","fpr")

str(perf)
#@ 表示槽的前缀，  表示是S4对象，要想访问AUC(ROC曲线)下方的面积，以列表形式存储在y.value中
#可以使用@ 和unlist()函数，将列表简化成数值向量, AUC值越大越好
perf_auc <- performance(pred,measure = 'auc')
str(perf_auc)
unlist(perf_auc@y.values)

#纵轴表示真阳性的比例（灵敏度），横轴表示假阳性的比例（特异性） 曲线越靠近y轴 性能越好，
#对角线说明没有预测价值的分类器
#图形称为 灵敏度/特异性图
plot(perf)
#a 表示截距， b表示斜率， lwd 线条粗细（linewide）， lty 表示线条类型（linetype）
#加入一条参考线表示无预测值的分类器
abline(a = 0, b = 1, lwd = 2, lty = 2) 

##############################################################
# 1 保留法， 分层抽样
#createDataPartition{caret} 分层抽样来创建随机的划分，返回的是索引
#time表示抽两次，得到两个样本集合， p表示包含在该划分中样本的比例，
#list = FALSE防止结果存储成列表
data = rgamma(50, 3, .5)
in_train = createDataPartition(data, time = 2, p = 0.7, list = FALSE)
data_train = data[in_train] #训练集
data_test = data[-in_train] #测试集

# 交叉验证
# k折交叉验证
data(oil)
# 10折交叉验证，是最常用的k折交叉验证 ， 将原始数据随机分成10个部分, 
#每一部分当做一折的测试数据，每一折取90% 的数据用来训练模型，10%用来测试模型
#createFolds()创建交叉验证的数据集，与分层抽样类似，
#该函数也尝试在每一折中维持与原始数据类似的个类别的比例，返回的是索引
length(oilType)
#保留10个作为训练集，返回索引
index = createFolds(oilType, 5)
#选出其中一折作为oilType的数据框中的行号
oil_train = oilType[index$Fold1] # 78 个数
oil_test = oilType[-index]  #18个数
#共重复10次，每一折建立一次模型，然后计算模型性能，最后通过对所有的性度量取平均值得到总体性能

#
library(caret)
library(C50)
data(churn)
churnTrain = churnTrain[,!names(churnTrain) %in% c("state",
                                                   "area_code", "account_length") ]
#head(churn)
#对要分类的变了，进行交叉验证
folds = createFolds(churnTrain$churn, k = 10)
#对列表应用每一列表
cv_results = lapply(folds, 
                    function(x){
  churn_train = churnTrain[x,] 
  churn_test = churnTrain[-x, ]
  churn_model = C5.0(churn ~ . , data = churn_train)
  churn_predict = predict(churn_model, churn_test)
  churn_actual = churn_test$churn
  #计算一个统计量
  kapp = confusionMatrix(churn_predict, churn_actual)$overall
  return(kapp)
  }
)
cv_results
#plyr包，将list转化为数据框
library(plyr)
str(cv_results)
RE = ldply(cv_results)
results = apply(RE[, -1], 2, mean)
results


