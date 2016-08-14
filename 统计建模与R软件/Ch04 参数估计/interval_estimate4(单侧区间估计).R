# 控制上下置信区间和双侧置信区间

interval_estimate4<-function(x, sigma=-1, side=0, alpha=0.05){ 
   n<-length(x); xb<-mean(x)
   if (sigma>=0){
      # 总体方差已知
      if (side<0){
        # 左侧均值的估计
         tmp<-sigma/sqrt(n)*qnorm(1-alpha)
         a <- -Inf; b <- xb+tmp
      }
      else if (side>0){
        # 右侧均值的估计
         tmp<-sigma/sqrt(n)*qnorm(1-alpha)
         a <- xb-tmp; b <- Inf
      }
      else{
        #双侧均值的估计
         tmp <- sigma/sqrt(n)*qnorm(1-alpha/2)
         a <- xb-tmp; b <- xb+tmp
      }
      df<-n
   }
   else{
     # 总体方差未知
      if (side<0){
        #左侧均值估计
         tmp <- sd(x)/sqrt(n)*qt(1-alpha,n-1)
         a <- -Inf; b <- xb+tmp
      }
      else if (side>0){
        #右侧均值估计
         tmp <- sd(x)/sqrt(n)*qt(1-alpha,n-1)
         a <- xb-tmp; b <- Inf
      }
      else{
        #双侧均值估计 
         tmp <- sd(x)/sqrt(n)*qt(1-alpha/2,n-1)
         a <- xb-tmp; b <- xb+tmp
      }
      df<-n-1
   }
   data.frame(mean=xb, df=df, a=a, b=b)
}
