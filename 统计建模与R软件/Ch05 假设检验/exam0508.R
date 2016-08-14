X<-c(210, 312, 170, 85, 223)
n<-sum(X); m<-length(X)
p<-rep(1/m, m)
K<-sum((X-n*p)^2/(n*p));K
Pr<-1-pchisq(K, m-1);Pr
