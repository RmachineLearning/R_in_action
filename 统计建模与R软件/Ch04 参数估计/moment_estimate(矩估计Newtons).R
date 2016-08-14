x<-rbinom(100, 20, 0.7); n<-length(x)
A1<-mean(x); M2<-(n-1)/n*var(x)
source("moment_fun.R"); 
source("../chapter02/Newtons.R")
p<-c(10,0.5); Newtons(moment_fun, p)

k<-A1^2/(A1-M2); k
p<-(A1-M2)/A1; p
