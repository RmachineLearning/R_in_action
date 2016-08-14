### 求线性模型系数的区间估计
beta.int<-function(fm,alpha=0.05){
   A<-summary(fm)$coefficients
   df<-fm$df.residual
   left<-A[,1]-A[,2]*qt(1-alpha/2, df)
   right<-A[,1]+A[,2]*qt(1-alpha/2, df)
   rowname<-dimnames(A)[[1]]
   colname<-c("Estimate", "Left", "Right")
   matrix(c(A[,1], left, right), ncol=3,
       dimnames = list(rowname, colname ))  
}
