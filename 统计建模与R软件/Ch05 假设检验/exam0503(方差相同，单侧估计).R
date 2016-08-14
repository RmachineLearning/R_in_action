X<-c(78.1, 72.4, 76.2, 74.3, 77.4, 78.4, 76.0, 75.5, 76.7, 77.3)
Y<-c(79.1, 81.0, 77.3, 79.1, 80.0, 79.1, 79.1, 77.3, 80.2, 82.1)
source("mean.test2.R")
mean.test2(X,Y, var.equal=TRUE, side=-1)
mean.test2(X,Y, side=-1)


#### 调用两个总体均值差的区间估计函数
source("../chapter04/interval_estimate5.R")
#### 作单侧区间估计, 并认为两总体方差相同
interval_estimate5(X, Y, var.equal=TRUE, side=-1)

t.test(X, Y, var.equal=TRUE, alternative = "less")