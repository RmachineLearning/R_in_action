cement<-data.frame(
   X1=c( 7,  1, 11, 11,  7, 11,  3,  1,  2, 21,  1, 11, 10),
   X2=c(26, 29, 56, 31, 52, 55, 71, 31, 54, 47, 40, 66, 68),
   X3=c( 6, 15,  8,  8,  6,  9, 17, 22, 18,  4, 23,  9,  8),
   X4=c(60, 52, 20, 47, 33, 22,  6, 44, 22, 26, 34, 12, 12),
   Y =c(78.5, 74.3, 104.3,  87.6,  95.9, 109.2, 102.7, 72.5, 
        93.1,115.9,  83.8, 113.3, 109.4)
)
lm.sol<-lm(Y ~ X1+X2+X3+X4, data=cement)
summary(lm.sol)

lm.step<-step(lm.sol)
lm.step$anova

summary(lm.step)

drop1(lm.step)

lm.opt<-lm(Y ~ X1+X2, data=cement); summary(lm.opt)