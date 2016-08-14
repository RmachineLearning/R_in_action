x<-c(1.000, 
     0.923, 1.000,
     0.841, 0.851, 1.000,  
     0.756, 0.807, 0.870, 1.000, 
     0.700, 0.775, 0.835, 0.918, 1.000, 
     0.619, 0.695, 0.779, 0.864, 0.928, 1.000, 
     0.633, 0.697, 0.787, 0.869, 0.935, 0.975, 1.000, 
     0.520, 0.596, 0.705, 0.806, 0.866, 0.932, 0.943, 1.000)
names<-c("X1", "X2", "X3", "X4", "X5", "X6", "X7", "X8")
R<-matrix(0, nrow=8, ncol=8, dimnames=list(names, names))
for (i in 1:8){
   for (j in 1:i){
      R[i,j]<-x[(i-1)*i/2+j]; R[j,i]<-R[i,j]
   }
}
source("factor.analy1.R")
fa<-factor.analy1(R, m=2); fa

E<- R-fa$loadings %*% t(fa$loadings)-diag(fa$var[,2])
sum(E^2)