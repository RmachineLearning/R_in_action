cotton<-data.frame(
   Y=c(0.30, 0.35, 0.20, 0.30, 0.15, 0.50, 0.15, 0.40),
   A=gl(2,4),
   B=gl(2,2,8),
   C=gl(2,1,8)
)
cotton.aov<-aov(Y~A+B+C+A:B+A:C+B:C, data=cotton)
source("anova.tab.R"); anova.tab(cotton.aov)

cotton.new<-aov(Y~B+C+A:C, data=cotton)
anova.tab(cotton.new)


ab<-function(x,y){
   n<-length(x); z<-rep(0,n)
   for (i in 1:n)
      if (x[i]==y[i]){z[i]<-1} else{z[i]<-2}
   factor(z)
}
cotton$AC<-ab(cotton$A, cotton$C)

K<-matrix(0, nrow=2, ncol=4, 
   dimnames=list(1:2, c("A", "B", "C", "AC")))
for (j in 2:5)
  for (i in 1:2)
     K[i,j-1]<-mean(cotton$Y[cotton[j]==i])
K

