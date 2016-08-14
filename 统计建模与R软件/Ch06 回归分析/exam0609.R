toothpaste<-data.frame(
   X1=c(-0.05, 0.25,0.60,0,   0.25,0.20, 0.15,0.05,-0.15, 0.15,
         0.20, 0.10,0.40,0.45,0.35,0.30, 0.50,0.50, 0.40,-0.05,
        -0.05,-0.10,0.20,0.10,0.50,0.60,-0.05,0,    0.05, 0.55),
   X2=c( 5.50,6.75,7.25,5.50,7.00,6.50,6.75,5.25,5.25,6.00,
         6.50,6.25,7.00,6.90,6.80,6.80,7.10,7.00,6.80,6.50,
         6.25,6.00,6.50,7.00,6.80,6.80,6.50,5.75,5.80,6.80),
   Y =c( 7.38,8.51,9.52,7.50,9.33,8.28,8.75,7.87,7.10,8.00,
         7.89,8.15,9.10,8.86,8.90,8.87,9.26,9.00,8.75,7.95,
         7.65,7.27,8.00,8.50,8.75,9.21,8.27,7.67,7.93,9.26)
)

lm.sol<-lm(Y~X1+X2,data=toothpaste)
summary(lm.sol)

attach(toothpaste)
plot(Y~X1); abline(lm(Y~X1))

lm2.sol<-lm(Y~X2+I(X2^2))
x<-seq(min(X2), max(X2), len=200)
y<-predict(lm2.sol, data.frame(X2=x))
plot(Y~X2); lines(x,y)

lm.new<-update(lm.sol, .~.+I(X2^2))
summary(lm.new)
source("beta.int.R")
beta.int(lm.new)

lm2.new<-update(lm.new, .~.-X2)
summary(lm2.new)

lm3.new<-update(lm.new, .~.+X1*X2)
summary(lm3.new)
