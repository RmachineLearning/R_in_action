commodity<-data.frame(
   X1=c( 82.9,  88.0,  99.9, 105.3, 117.7, 
        131.0, 148.2, 161.8, 174.2, 184.7), 
   X2=c(92, 93, 96, 94, 100, 101, 105, 112, 112, 112), 
   X3=c(17.1, 21.3, 25.1, 29.0, 34.0, 40.0, 44.0, 
        49.0, 51.0, 53.0), 
   X4=c(94, 96, 97, 97, 100, 101, 104, 109, 111, 111), 
   Y=c(8.4, 9.6, 10.4, 11.4, 12.2, 14.2, 15.8, 17.9, 
       19.6, 20.8)
)

attach(commodity)
opar<-par(mfrow=c(2,2), mar=c(5,4,1,1))
plot(X1, Y); plot(X2, Y); plot(X3, Y); plot(X4, Y)
par(opar)

lm.sol<-lm(Y~X1+X2+X3+X4, data=commodity)
summary(lm.sol)

commodity.pr<-princomp(~X1+X2+X3+X4, data=commodity, cor=T)
summary(commodity.pr, loadings=TRUE)

pre<-predict(commodity.pr)
commodity$Z<-pre[,1]
lm.sol<-lm(Y~Z, data=commodity)
summary(lm.sol)

beta<-coef(lm.sol); A<-loadings(commodity.pr)
x.bar<-commodity.pr$center; x.sd<-commodity.pr$scale
coef<-beta[2]*A[,1]/x.sd
beta0 <- beta[1]- sum(x.bar * coef)
c(beta0, coef)



