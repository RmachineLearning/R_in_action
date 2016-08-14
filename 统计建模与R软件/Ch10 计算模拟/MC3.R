MC3<-function(n){
   D<-3; pi<-3.1416; back<-0; absorb<-0; pierce<-0
   for (k in 1:n){
      x<- -log(runif(1))  
      for (i in 1:10){
         index <- 1
         r <- runif(2); R <- -log(r[1]); t <- 2*pi*r[2]
         x <- x + R * cos(t)
         if (x<0) {
            back<-back+1; index<-0; break 
         }else if (x>D){
            pierce<-pierce+1; index<-0; break
         }else
            next
      }
      if (index==1)
         absorb<-absorb+1
   }
   data.frame(Pierce=pierce/n*100, Absorb=absorb/n*100, 
              Back=back/n*100)
}