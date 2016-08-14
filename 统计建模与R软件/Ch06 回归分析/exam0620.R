life<-data.frame(
   X1=c(2.5, 173, 119, 10, 502, 4, 14.4, 2, 40, 6.6, 
        21.4, 2.8, 2.5, 6, 3.5, 62.2, 10.8, 21.6, 2, 3.4, 
        5.1, 2.4, 1.7, 1.1, 12.8, 1.2, 3.5, 39.7, 62.4, 2.4,
        34.7, 28.4, 0.9, 30.6, 5.8, 6.1, 2.7, 4.7, 128, 35, 
        2, 8.5, 2, 2, 4.3, 244.8, 4, 5.1, 32, 1.4),
   X2=rep(c(0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2,
            0, 2, 0, 2, 0, 2, 0),
          c(1, 4, 2, 2, 1, 1, 8, 1, 5, 1, 5, 1, 1, 1, 2, 1,
            1, 1, 3, 1, 2, 1, 4)),
   X3=rep(c(0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1), 
          c(6, 1, 3, 1, 3, 1, 1, 5, 1, 3, 7, 1, 1, 3, 1, 1, 2, 9)),
   Y=rep(c(0,  1,   0,  1), c(15, 10, 15, 10))
)
glm.sol<-glm(Y~X1+X2+X3, family=binomial, data=life)
summary(glm.sol)

pre<-predict(glm.sol, data.frame(X1=5,X2=2,X3=0))
p<-exp(pre)/(1+exp(pre));p

pre<-predict(glm.sol, data.frame(X1=5,X2=2,X3=1))
p<-exp(pre)/(1+exp(pre));p

step(glm.sol)

glm.new<-update(glm.sol, .~.-X1)
summary(glm.new)

pre<-predict(glm.new, data.frame(X2=2,X3=0))
p<-exp(pre)/(1+exp(pre));p

pre<-predict(glm.new, data.frame(X2=2,X3=1))
p<-exp(pre)/(1+exp(pre));p

source("Reg_Diag.R"); Reg_Diag(glm.sol)

Reg_Diag(glm.new)