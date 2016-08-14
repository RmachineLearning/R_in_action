MC1_2 <- function(n){
   x <- runif(n)
   4*sum(sqrt(1-x^2))/n
}
