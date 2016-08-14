factor.analy2<-function(R, m, d){
   p<-nrow(R); diag_R<-diag(R); sum_rank<-sum(diag_R)
   rowname<-paste("X", 1:p, sep="")
   colname<-paste("Factor", 1:m, sep="")
   A<-matrix(0, nrow=p, ncol=m, 
             dimnames=list(rowname, colname))

   kmax=20; k<-1; h <- diag_R-d
   repeat{
      diag(R)<- h; h1<-h; eig<-eigen(R)
      for (i in 1:m)
         A[,i]<-sqrt(eig$values[i])*eig$vectors[,i]
      h<-diag(A %*% t(A))
      if ((sqrt(sum((h-h1)^2))<1e-4)|k==kmax) break
      k<-k+1
   }

   rowname<-c("SS loadings", "Proportion Var", "Cumulative Var")
   B<-matrix(0, nrow=3, ncol=m, 
             dimnames=list(rowname, colname))
   for (i in 1:m){
     B[1,i]<-sum(A[,i]^2)
     B[2,i]<-B[1,i]/sum_rank
     B[3,i]<-sum(B[1,1:i])/sum_rank
   }
   method<-c("Principal Factor Method")
   list(method=method, loadings=A, 
        var=cbind(common=h, spcific=diag_R-h), B=B, iterative=k) 
}   
