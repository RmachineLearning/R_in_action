norell<-data.frame(
   x=0:5, n=rep(70,6), success=c(0,9,21,47,60,63)
)
norell$Ymat<-cbind(norell$success, norell$n-norell$success)
glm.sol<-glm(Ymat~x, family=binomial, data=norell)
summary(glm.sol)

pre<-predict(glm.sol, data.frame(x=3.5))
p<-exp(pre)/(1+exp(pre));p

X<- - glm.sol$coefficients[1]/glm.sol$coefficients[2];X

d<-seq(0,5, len=100)
pre<-predict(glm.sol, data.frame(x=d))
p<-exp(pre)/(1+exp(pre))
norell$y<-norell$success/norell$n
plot(norell$x,norell$y)
lines(d,p)

