factor.analy<-function(S, m=0, 
   d=1/diag(solve(S)), method="likelihood"){
   if (m==0){
      p<-nrow(S); eig<-eigen(S) 
      sum_eig<-sum(diag(S))
      for (i in 1:p){
         if (sum(eig$values[1:i])/sum_eig>0.70){
             m<-i; break
         }
      }
   }
   source("factor.analy1.R")
   source("factor.analy2.R")
   source("factor.analy3.R")
   switch(method, 
             princomp=factor.analy1(S, m),
             factor=factor.analy2(S, m, d),
             likelihood=factor.analy3(S, m, d)
          ) 
}

   