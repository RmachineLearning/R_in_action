MC1 <- function(n){
   k <- 0; x <- runif(n); y <- runif(n)
   for (i in 1:n){
      if (x[i]^2+y[i]^2 < 1)
         k <- k+1
   }
   4*k/n
}