queue1<-function(lambda, mu, T){
   k<-0; wt<-0; wn<-0; ws<-0; 
   tp<-0; nA<-0; n<-0; t<-0
   r<-runif(1); tA<--1/lambda*log(r); tD<-Inf

   repeat{
      k<-k+1; wt[k]<-t; wn[k]<-n
      if (tA < T){
         ws[k]<-min(tA, tD)-t
         if (tA < tD){
            t<-tA; n<-n+1; nA<-nA+1
            r<-runif(1); tA<-t-1/lambda*log(r)
            if (n==1){
               r<-runif(1); tD<-t-1/mu*log(r)
            }    
         }else{
            t<-tD; n<-n-1
            if (n==0){
               tD<-Inf
            }else{
               r<-runif(1); tD<-t-1/mu*log(r)
            }    
         }
      }else{
         ws[k]<-if(tD==Inf) 0 else tD-t
         if (n>0){
            t<-tD; n<-n-1
            if (n>0){
               r<-runif(1); tD<-t-1/mu*log(r)
            }
         }else
            tp<-1
      }
      if (tp==1) break
   }
   data.frame(Ls=sum(ws*wn)/t, Ws=sum(ws*wn)/nA, 
                   Pwait=sum(ws[wn>=1])/t)
}