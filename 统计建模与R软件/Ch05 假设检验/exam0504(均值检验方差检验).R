#### 输入数据
X<-scan()
136  144  143  157  137  159  135  158  147  165
158  142  159  150  156  152  140  149  148  155

#### 均值检验
source("mean.test1.R")
mean.test1(X,mu=149, sigma=sqrt(75))
mean.test1(X,mu=149)

#### 方差检验
source("var.test1.R")
var.test1(X,sigma2=75, mu=149)
var.test1(X,sigma2=75)
