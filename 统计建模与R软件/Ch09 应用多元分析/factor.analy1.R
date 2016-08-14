factor.analy1<-function(S, m){
   p<-nrow(S); diag_S<-diag(S); sum_rank<-sum(diag_S)
   rowname<-paste("X", 1:p, sep="")
   colname<-paste("Factor", 1:m, sep="")
   A<-matrix(0, nrow=p, ncol=m, 
             dimnames=list(rowname, colname))
   eig<-eigen(S)
   for (i in 1:m)
      A[,i]<-sqrt(eig$values[i])*eig$vectors[,i]
   h<-diag(A%*%t(A))

   rowname<-c("SS loadings", "Proportion Var", "Cumulative Var")
   B<-matrix(0, nrow=3, ncol=m, 
             dimnames=list(rowname, colname))
   for (i in 1:m){
     B[1,i]<-sum(A[,i]^2)
     B[2,i]<-B[1,i]/sum_rank
     B[3,i]<-sum(B[1,1:i])/sum_rank
   }
   method<-c("Principal Component Method")
   list(method=method, loadings=A, 
        var=cbind(common=h, spcific=diag_S-h), B=B) 
}