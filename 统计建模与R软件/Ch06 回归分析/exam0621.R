alloy<-data.frame(
   x=c(37.0, 37.5, 38.0, 38.5, 39.0, 39.5, 40.0, 
       40.5, 41.0, 41.5, 42.0, 42.5, 43.0),
   y=c(3.40, 3.00, 3.00, 3.27, 2.10, 1.83, 1.53, 
       1.70, 1.80, 1.90, 2.35, 2.54, 2.90)
)
lm.sol<-lm(y~1+x+I(x^2),data=alloy)
summary(lm.sol)

xfit<-seq(37,43,len=200)
yfit<-predict(lm.sol, data.frame(x=xfit))
plot(alloy$x,alloy$y)
lines(xfit, yfit)

lm.pol<-lm(y~1+poly(x,2),data=alloy)
summary(lm.pol)
xfit<-seq(37,43,len=200)
yfit<-predict(lm.pol, data.frame(x=xfit))
plot(alloy$x,alloy$y)
lines(xfit, yfit)

