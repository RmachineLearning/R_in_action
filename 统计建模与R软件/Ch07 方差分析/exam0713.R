rate<-data.frame(
   A=gl(3,3), 
   B=gl(3,1,9),
   C=factor(c(1,2,3,2,3,1,3,1,2)),
   Y=c(31, 54, 38, 53, 49, 42, 57, 62, 64)
)
K<-matrix(0, nrow=3, ncol=3, dimnames=list(1:3, c("A", "B", "C")))
for (j in 1:3)
  for (i in 1:3)
     K[i,j]<-mean(rate$Y[rate[j]==i])
K

plot(as.vector(K),axes=F, xlab="Level", ylab="Rate")
xmark<-c(NA,"A1","A2","A3","B1","B2","B3","C1","C2","C3",NA)
axis(1,0:10,labels=xmark)
axis(2,4*10:16)
axis(3,0:10,labels=xmark)
axis(4,4*10:16)
lines(K[,"A"]); lines(4:6, K[,"B"]); lines(7:9,K[,"C"])

rate.aov<-aov(Y~A+B+C, data=rate)
source("anova.tab.R"); anova.tab(rate.aov)