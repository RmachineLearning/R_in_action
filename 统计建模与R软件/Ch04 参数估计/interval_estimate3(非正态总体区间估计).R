interval_estimate3<-function(x,sigma=-1,alpha=0.05){ 
   n<-length(x); xb<-mean(x)
   if (sigma>=0)
     #总体方差已知情况下
      tmp<-sigma/sqrt(n)*qnorm(1-alpha/2)
   else
     #如果总体方差未知，则用样本方差代替总体方差
      tmp<-sd(x)/sqrt(n)*qnorm(1-alpha/2)
   data.frame(mean=xb, a=xb-tmp, b=xb+tmp)
}