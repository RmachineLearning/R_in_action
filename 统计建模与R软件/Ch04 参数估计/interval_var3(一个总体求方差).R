# 控制上置信区间和  双侧置信区间
interval_var3<-function(x,mu=Inf,side=0,alpha=0.05){ 
   n<-length(x)
   if (mu<Inf){
     #当均值已知时，求方差
      S2<-sum((x-mu)^2)/n; df<-n
   }
   else{
     # 当均值未知时，求方差
      S2<-var(x); df<-n-1
   }
   
   if (side<0){
     #左侧置信区间
      a <- 0
      b <- df*S2/qchisq(alpha,df)
   }
   else if (side>0){
     # 右侧置信区间
      a <- df*S2/qchisq(1-alpha,df)
      b <- Inf
   }
   else{
     # 双侧置信区间
      a<-df*S2/qchisq(1-alpha/2,df)
      b<-df*S2/qchisq(alpha/2,df)
   }
   data.frame(var=S2, df=df, a=a, b=b)
}
