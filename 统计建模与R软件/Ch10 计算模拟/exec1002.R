plot(c(0,0,33), c(0,20,0), xlab =" ", ylab = " ")
text(33, 0, labels="A", adj=c( 0.5, -0.5))
text(0, 20, labels="B", adj=c( -.5, 0.3))
text(0, 0, labels="O", adj=c( 1.3, 0.3))
lines(c(33,0,0), c(0,0,20))

delta_t<-0.1; n=201
x<-matrix(0, nrow=2, ncol=n); x[,1]<-c(33,0)
y<-matrix(0, nrow=2, ncol=n); y[,1]<-c(0, 0)
for (j in 1:(n-1)){
   d <-sqrt((x[2, j]-x[1,j])^2+(y[2, j]-y[1,j])^2) 
   x[1,j+1]<-x[1,j]+2*delta_t*(x[2,j]-x[1,j])/d
   y[1,j+1]<-y[1,j]+2*delta_t*(y[2,j]-y[1,j])/d
   x[2, j+1]<-0; y[2, j+1]<-delta_t*j
}
lines(x[1,], y[1,])

