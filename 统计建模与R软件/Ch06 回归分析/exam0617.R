intellect<-data.frame(
  x=c(15, 26, 10,  9, 15, 20, 18, 11,  8, 20, 7,
       9, 10, 11, 11, 10, 12, 42, 17, 11, 10),
  y=c(95, 71, 83,  91, 102,  87, 93, 100, 104,  94, 113,
      96, 83, 84, 102, 100, 105, 57, 121,  86, 100)
) 

lm.sol<-lm(y~x, data=intellect)
summary(lm.sol)

source("Reg_Diag.R"); Reg_Diag(lm.sol)

opar <- par(mfrow = c(2, 2), oma = c(0, 0, 1.1, 0),
                 mar = c(4.1, 4.1, 2.1, 1.1))
plot(lm.sol,1); plot(lm.sol,3); plot(lm.sol,4)
attach(intellect)
plot(x,y); X<-x[18:19];Y<-y[18:19]
text(X,Y, labels=18:19,adj=1.2); abline(lm.sol)
par(opar)
