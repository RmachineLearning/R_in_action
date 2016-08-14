X<-c(78.1, 72.4, 76.2, 74.3, 77.4, 78.4, 76.0, 75.5, 76.7, 77.3)
Y<-c(79.1, 81.0, 77.3, 79.1, 80.0, 79.1, 79.1, 77.3, 80.2, 82.1)
source("var.test2.R")
var.test2(X,Y)
#var.test2(X,Y, mu=c(mean(X), mean(Y)))

#### 作方差比的区间估计
source("../chapter04/interval_var4.R")
interval_var4(X,Y)

#### 方差检验
var.test(X,Y)