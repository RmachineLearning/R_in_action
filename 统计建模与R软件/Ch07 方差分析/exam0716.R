mosquito<-data.frame(
  A=gl(3, 12),
  B=gl(3,4,36),
  C=factor(rep(c(1,2,3,2,3,1,3,1,2),rep(4,9))),
  D=factor(rep(c(1,2,3,3,1,2,2,3,1),rep(4,9))),
  Y=c( 9.41,  7.19, 10.73,  3.73, 11.91, 11.85, 11.00, 11.72,
      10.67, 10.70, 10.91, 10.18,  3.87,  3.18,  3.80,  4.85, 
       4.20,  5.72,  4.58,  3.71,  4.29,  3.89,  3.88,  4.71,
       7.62,  7.01,  6.83,  7.41,  7.79,  7.38,  7.56,  6.28,  
       8.09,  8.17,  8.14,  7.49)
)
mosquito.aov<-aov(Y~A+B+C+D, data=mosquito)
source("anova.tab.R"); anova.tab(mosquito.aov)

K<-matrix(0, nrow=3, ncol=4, 
   dimnames=list(1:3, c("A", "B", "C", "D")))
for (j in 1:4)
  for (i in 1:3)
     K[i,j]<-mean(mosquito$Y[mosquito[j]==i])
K




 