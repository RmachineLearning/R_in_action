interval_estimate5<-function(x, y, 
   sigma=c(-1,-1), var.equal=FALSE, side=0, alpha=0.05){ 
   n1<-length(x); n2<-length(y)
   xb<-mean(x); yb<-mean(y); zb<-xb-yb
   if (all(sigma>=0)){
     # 两个总体方差都已知
      if (side<0){
        # 左侧区间估计
         tmp<-qnorm(1-alpha)*sqrt(sigma[1]^2/n1+sigma[2]^2/n2)
         a <- -Inf; b <- zb+tmp
      }
      else if (side>0){
        # 右侧区间估计
         tmp<-qnorm(1-alpha)*sqrt(sigma[1]^2/n1+sigma[2]^2/n2)
         a <- zb-tmp; b <- Inf
      }
      else{
        # 双侧区间估计
         tmp<-qnorm(1-alpha/2)*sqrt(sigma[1]^2/n1+sigma[2]^2/n2)
         a <- zb-tmp; b <- zb+tmp
      }
      df<-n1+n2
   }
   else{
     # 两个总体方差未知时
      if (var.equal ==  TRUE){
        #两个总体方差未知，且相对时
         Sw<-((n1-1)*var(x)+(n2-1)*var(y))/(n1+n2-2)
         if (side<0){
           # 左侧
            tmp<-sqrt(Sw*(1/n1+1/n2))*qt(1-alpha,n1+n2-2)
            a <- -Inf; b <- zb+tmp
         }
         else if (side>0){
           # 右侧
            tmp<-sqrt(Sw*(1/n1+1/n2))*qt(1-alpha,n1+n2-2)
            a <- zb-tmp; b <- Inf
         }
         else{
           # 双侧 
            tmp<-sqrt(Sw*(1/n1+1/n2))*qt(1-alpha/2,n1+n2-2)
            a <- zb-tmp; b <- zb+tmp
         }
         df<-n1+n2-2
      }
      else{
        # 两个总体方差未知，且不相等时
         S1<-var(x); S2<-var(y)
         nu<-(S1/n1+S2/n2)^2/(S1^2/n1^2/(n1-1)+S2^2/n2^2/(n2-1))
         if (side<0){
            tmp<-qt(1-alpha, nu)*sqrt(S1/n1+S2/n2)
            a <- -Inf; b <- zb+tmp
         }
         else if (side>0){
            tmp<-qt(1-alpha, nu)*sqrt(S1/n1+S2/n2)
            a <- zb-tmp; b <- Inf
         }
         else{
            tmp<-qt(1-alpha/2, nu)*sqrt(S1/n1+S2/n2)
            a <- zb-tmp; b <- zb+tmp
         }
         df<-nu
      }
   }
   data.frame(mean=zb, df=df, a=a, b=b)
}
