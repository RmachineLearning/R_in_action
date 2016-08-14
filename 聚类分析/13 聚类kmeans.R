#寻找数据的分组
getwd()
setwd("/media/zhoutao/软件盘/workspace/R/Data for An Introduction to Statistical Learning with Applications in R ")

###k均值

#kmeans{stats}
##1 收集数据，整理数据
customer = read.csv('./ml_R_cookbook-master/CH9/customer.csv', head = TRUE)
head(customer)
customer = scale(customer[,-1]) #聚类时要无量纲化

##建立模型
fit = kmeans(customer, 4)

##模型评估
#Cluster means: 
fit 
#Clustering vector:是kmeans()函数给出的类成员向量，
fit$cluster 
#Cluster means: 含有每个类组合和每一个特征的均值的一个矩阵，查看聚类质心的坐标
fit$centers
#给出每一个类中实例的个数，最小的类包含8个customer,占13% 
fit$size

###提升性能
  ##首先将fit$centers应用回完整的数据集, fit$cluster 包含60个消费者的类的划分
customer = transform(customer, cluser = fit$cluster)
  #根据这一信息可以确定每一位用户被分配到哪一类中
  #查看前5位
customer[1:5, ]

#可视化kmeans聚类
barplot(t(fit$centers), beside = TRUE,xlab="cluster", ylab="value")
#散点图聚类
plot(customer, col = fit$cluster)

#画二元变量聚类图
#install.packages("cluster")
library(cluster)
clusplot(customer, fit$cluster, color=TRUE, shade=TRUE)

par(mfrow= c(1,2))
clusplot(customer, fit$cluster, color=TRUE, shade=TRUE)
rect(-0.7,-1.7, 2.2,-1.2, border = "orange", lwd=2) #放大
clusplot(customer, fit$cluster, color = TRUE, xlim = c(-0.7,2.2), ylim = c(-1.7,-1.2))


#使用kmean计算剪影信息
kms = silhouette(fit $cluster,dist(customer))
summary(kms)
plot(kms)

#优化kmeans， 经验规则建议设置k = sqrt(n/2),统计方法得出选择拐弯处的k最佳，称为肘点
nk = 2:10
WSS = sapply(nk, function(k) {
          kmeans(customer, centers=k)$tot.withinss
   })
plot(nk, WSS, type="l", xlab= "number of k", ylab="within sum of squares")

