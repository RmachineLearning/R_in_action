setwd("/media/zhoutao/软件盘/workspace/R/Data for An Introduction to Statistical Learning with Applications in R ")
#神经网络， 神经网络包neuralnet



#神经网络
#install.packages('neuralnet')
library(neuralnet)
library(caret)
#m = neuralnet(targe ~ predictors, data = mydata, hidden = 1)
#targe 数据框mydata中需要建模的输出变量
#prediction 自变量
#hidden 给出隐藏层中神经元的数目，默认为1
data(infert, package="datasets")
infert_index = createDataPartition(infert, p = 0.75, list = FALSE)
infert_train = infert[infert_index, ]
infert_test = infert[-infert_index, ]
net_model <- neuralnet(case~parity+induced+spontaneous, 
                        data = infert_train,  err.fct="ce", 
                        linear.output=FALSE, likelihood=TRUE, 
                        hidden = 2)
# Error 误差平方和，step训练的步骤
net_model
#途中带有1的节点 表示每一个连接的权重(偏差项)
plot(net_model)
#预测
#p = compute(m, test)
#test 测试集
#返回列表中，$neurons 用于保存神经网络每一层的神经元
#$net.result 保存模型的预测值
head(infert_test)
#取parity+induced+spontaneous三个变量
model_results = compute(net_model, infert_test[,c(3, 4, 6)])

##neurons 存储网络中每一层神经元
model_results$neurons 
#net.results存储预测值
model_results$net.results
#如果预测值(y)是数值型，则用相关性检验预测值与真实值的相关关系， 正相关性越强说明模型越好
#如果预测值是分类型，则用混淆矩阵来检验

#提高性能， hidden参数的的隐藏层增加，然后查看Error是否变小了，相关系数变大了没有
