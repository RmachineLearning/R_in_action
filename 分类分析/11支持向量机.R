setwd("/media/zhoutao/软件盘/workspace/R/Data for An Introduction to Statistical Learning with Applications in R ")
#支持向量机


##1 收集数据
#promotergene {kernlab} DNA序列数据， 确实因子型数据
data(promotergene)
str(promotergene)
head(promotergene)
table(promotergene$Class) #53个+ 53个-
##2 探索和准备数据
#随机取列表
ind <- sample(1:dim(promotergene)[1],20)
genetrain <- promotergene[-ind, ]
#dim(genetrain)
genetest <- promotergene[ind, ]
#dim(genetest)

##3 基于数据训练模型
#kernlab包 可以与caret添加包一起使用，这就允许支持向量集模型可以使用各种自动化方法
#进行训练和评估
install.packages('kernlab')
library(kernlab)
#m = ksvm(target ~ predictors, data = mydata, kernel = 'rbfdot', c =1)
#target 因变量
#prediction 自变量
#kernel 给出隐一个非线性映射，例如rbfdot (径向基函数) polydot（多项式函数）tanhdot(双曲正切函数)
#vanilladot（线性函数）
#C 用于给出违法约束条件时的惩罚，即对‘软边界’的惩罚大小，较大的c值将导致较窄的边界，
#该函数返回一个用于预测的SVM对象
gene <- ksvm(Class~., data=genetrain, kernel="rbfdot",
             kpar=list(sigma=0.015),C=70,cross=4,prob.model=TRUE)
gene
##4 
#p = predict(m, test, type = 'response')
#m svm模型， test 测试集， 
#type 用于指定预测的类型为‘response’（预测类别）或者‘probabilities’(预测概率，每一列对应一个类水平值)
#根据type的设定会返回一个包含预测类别（或者概率）的向量（或矩阵），两个元素列表
#$neurons 保存神经网络每一层的神经元； $net.result保存模型的预测值

#type="probabilities" 给出预测值的概率
genetype_pr <- predict(gene, genetest, type="probabilities")
dim(genetype)
head(genetype)
#predict 默认type = 'response' 这样返回一个向量，对应测试数据中每一行值的一个预测字符，
genetype_re  <- predict(gene, genetest, type = 'response')
head(genetype_re)
#用table查看预测的正确性
table(genetype_re, genetest$Class)
#计算百分比
agreement = genetype_re  == genetest$Class
table(agreement)
prop.table(table(agreement))


#5 提高性能
#跟换更复杂的核
gene <- ksvm(Class~., data=genetrain, kernel="polydot",
             kpar=list(sigma=0.015),C=70,cross=4,prob.model=TRUE)


