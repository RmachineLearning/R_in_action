fn<-function(p, X, Y){
    f <- Y-p[1]-(0.49-p[1])*exp(-p[2]*(X-8))
    res<-sum(f^2)
    f1<- -1+exp(-p[2]*(X-8))
    f2<- (0.49-p[1])*exp(-p[2]*(X-8))*(X-8)
    J<-cbind(f1,f2)
    attr(res, "gradient") <- 2*t(J)%*%f
    res
} 

nlm(fn, p=c(0.1, 0.01), X=cl$X, Y=cl$Y, hessian=TRUE)