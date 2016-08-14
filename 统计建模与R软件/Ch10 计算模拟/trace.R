plot(c(0,1,1,0), c(0,0,1,1), xlab =" ", ylab = " ")
text(0, 1, labels="A", adj=c( 0.3, 1.3))
text(1, 1, labels="B", adj=c( 1.5, 0.5))
text(1, 0, labels="C", adj=c( 0.3, -0.8))
text(0, 0, labels="D", adj=c(-0.5, 0.1))
points(0.5,0.5); text(0.5, 0.5, labels="O", adj=c(-1.0, 0.3))

delta_t<-0.01; n=110
x<-matrix(0, nrow=5, ncol=n); x[,1]<-c(0,1,1,0,0)
y<-matrix(0, nrow=5, ncol=n); y[,1]<-c(1,1,0,0,1)
d<-c(0,0,0,0)
for (j in 1:(n-1)){
   for (i in 1:4){
      d[i] <-sqrt((x[i+1, j]-x[i,j])^2+(y[i+1, j]-y[i,j])^2) 
      x[i,j+1]<-x[i,j]+delta_t*(x[i+1,j]-x[i,j])/d[i]
      y[i,j+1]<-y[i,j]+delta_t*(y[i+1,j]-y[i,j])/d[i]
   }
   x[5,j+1]<-x[1, j+1]; y[5, j+1]<-y[1, j+1]
}
for (i in 1:4) lines(x[i,], y[i,])


