#### 用数据框的形式输入数据
conomy<-data.frame(
  x1=c(149.3, 161.2, 171.5, 175.5, 180.8, 190.7, 
       202.1, 212.4, 226.1, 231.9, 239.0),
  x2=c(4.2, 4.1, 3.1, 3.1, 1.1, 2.2, 2.1, 5.6, 5.0, 5.1, 0.7),
  x3=c(108.1, 114.8, 123.2, 126.9, 132.1, 137.7, 
       146.0, 154.1, 162.3, 164.3, 167.6),
  y=c(15.9, 16.4, 19.0, 19.1, 18.8, 20.4, 22.7, 
      26.5, 28.1, 27.6, 26.3)
)
#### 作线性回归
lm.sol<-lm(y~x1+x2+x3, data=conomy)
summary(lm.sol)

#### 作主成分分析
conomy.pr<-princomp(~x1+x2+x3, data=conomy, cor=T)
summary(conomy.pr, loadings=TRUE)

#### 预测测样本主成分, 并作主成分分析
pre<-predict(conomy.pr)
conomy$z1<-pre[,1]
conomy$z2<-pre[,2]
lm.sol<-lm(y~z1+z2, data=conomy)
summary(lm.sol)

#### 作变换, 得到原坐标下的关系表达式
beta<-coef(lm.sol); A<-loadings(conomy.pr)
x.bar<-conomy.pr$center; x.sd<-conomy.pr$scale
coef<-(beta[2]*A[,1]+ beta[3]*A[,2])/x.sd
beta0 <- beta[1]- sum(x.bar * coef)
c(beta0, coef)


