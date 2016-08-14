buffon<-function(n, l=0.8, a=1){
   k<-0
   theta<-runif(n,0, pi); x<-runif(n,0, a/2) 
   for (i in 1:n){
    if (x[i]<= l/2*sin(theta[i]))
       k<-k+1
  }  
  2*l*n/(k*a)
}