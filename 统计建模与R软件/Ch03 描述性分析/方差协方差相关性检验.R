rubber<-read.table("rubber.data")
mean(rubber)
cov(rubber)
cor(rubber)

attach(rubber)
cor.test(X1,X2)
cor.test(X1,X3)
cor.test(X2,X3)

