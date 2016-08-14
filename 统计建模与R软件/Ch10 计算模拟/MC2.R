MC2<-function(n){
   r1<-runif(n); r2<-runif(n); t2<-rnorm(n,30,2)
   t1<-array(0,dim=c(1,n)); t3<-t1;
   for(i in 1:n){
      if (r1[i]<=0.7){
          t1[i]<-0
      }else if (r1[i]<=0.9){
          t1[i]<-5 
      }else 
          t1[i]<-10
   }
   for(i in 1:n){
      if (r2[i]<=0.3){
          t3[i]<-28
      }else if (r2[i]<=0.7){
          t3[i]<-30
      }else if (r2[i]<=0.9){
          t3[i]<-32 
      }else 
          t3[i]<-34
   }
   k<-0
   for(i in 1:n)
      if (t1[i]+t2[i]>t3[i])  k<-k+1
   k/n
}