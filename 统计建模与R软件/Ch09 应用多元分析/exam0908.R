d<-c(0.123, 0.112, 0.155, 0.116, 0.073, 0.045, 0.033, 0.095)
source("factor.analy2.R")
fa<-factor.analy2(R, m=2, d); fa

E<- R-fa$loadings %*% t(fa$loadings)-diag(fa$var[,2])
sum(E^2)
