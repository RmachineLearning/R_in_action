# 总体方差已知，和方差未知两种情况下均值的区间估计
interval_estimate1<-function(x,sigma=-1,alpha=0.05){ 
   n<-length(x); xb<-mean(x)
   if (sigma>=0){
     # 方差已知
      tmp<-sigma/sqrt(n)*qnorm(1-alpha/2); df<-n
   }
   else{
     # 方差未知
      tmp<-sd(x)/sqrt(n)*qt(1-alpha/2,n-1); df<-n-1
   }
   data.frame(mean=xb, df=df, a=xb-tmp, b=xb+tmp)
}
