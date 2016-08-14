blood<-data.frame(
   X1=c(76.0, 91.5, 85.5, 82.5, 79.0, 80.5, 74.5, 
        79.0, 85.0, 76.5, 82.0, 95.0, 92.5),
   X2=c(50, 20, 20, 30, 30, 50, 60, 50, 40, 55, 
        40, 40, 20),
   Y= c(120, 141, 124, 126, 117, 125, 123, 125,
        132, 123, 132, 155, 147)
)
lm.sol<-lm(Y ~ X1+X2, data=blood)
summary(lm.sol)


y.res<-resid(lm.sol)
y.fit<-predict(lm.sol)
plot(y.res~y.fit)

y.rst<-rstandard(lm.sol)
plot(y.rst~y.fit)

