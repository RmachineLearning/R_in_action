moment_fun<-function(p){
   f<-c(p[1]*p[2]-A1, p[1]*p[2]-p[1]*p[2]^2-M2)
   J<-matrix(c(p[2], p[1], 
               p[2]-p[2]^2, p[1]-2*p[1]*p[2]), 
             nrow=2, byrow=T)
   list(f=f, J=J)
}