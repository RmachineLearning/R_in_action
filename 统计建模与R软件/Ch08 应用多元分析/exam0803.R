TrnX1<-matrix(
   c(24.8, 24.1, 26.6, 23.5, 25.5, 27.4, 
     -2.0, -2.4, -3.0, -1.9, -2.1, -3.1),
   ncol=2)
TrnX2<-matrix(
   c(22.1, 21.6, 22.0, 22.8, 22.7, 21.5, 22.1, 21.4, 
     -0.7, -1.4, -0.8, -1.6, -1.5, -1.0, -1.2, -1.3),
   ncol=2)
source("discriminiant.bayes.R")
#### 样本协方差相同
discriminiant.bayes(TrnX1, TrnX2, rate=8/6, var.equal=TRUE)
#### 样本协方差不同
discriminiant.bayes(TrnX1, TrnX2, rate=8/6)
