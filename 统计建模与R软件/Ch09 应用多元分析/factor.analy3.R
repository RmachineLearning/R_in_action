factor.analy3<-function(S, m, d){
   p<-nrow(S); diag_S<-diag(S); sum_rank<-sum(diag_S)
   rowname<-paste("X", 1:p, sep="")
   colname<-paste("Factor", 1:m, sep="")
   A<-matrix(0, nrow=p, ncol=m, 
             dimnames=list(rowname, colname))

   kmax=20; k<-1 
   repeat{
      d1<-d; d2<-1/sqrt(d); eig<-eigen(S * (d2 %o% d2))
      for (i in 1:m)
         A[,i]<-sqrt(eig$values[i]-1)*eig$vectors[,i]
      A<-diag(sqrt(d)) %*% A
      d<-diag(S-A%*%t(A))
      if ((sqrt(sum((d-d1)^2))<1e-4)|k==kmax) break
      k<-k+1
   }

   rowname<-c("SS loadings","Proportion Var","Cumulative Var")
   B<-matrix(0, nrow=3, ncol=m, 
             dimnames=list(rowname, colname))
   for (i in 1:m){
     B[1,i]<-sum(A[,i]^2)
     B[2,i]<-B[1,i]/sum_rank
     B[3,i]<-sum(B[1,1:i])/sum_rank
   }
   method<-c("Maximum Likelihood Method")
   list(method=method, loadings=A, 
        var=cbind(common=diag_S-d, spcific=d),B=B,iterative=k) 
}   

