
myFactorial <- function(n){
  if(n < 0){
    stop('The argument "n" must be positive')
  } else if(n != round(n)){
    warning('The "factorial" function was used')
    return(factorial(n))
  } else if(n > 0){
    return(n*Recall(n-1))
  } else {
    return(1)
  }
}

myFactorial(4)
myFactorial(3.5)
myFactorial(-1)
