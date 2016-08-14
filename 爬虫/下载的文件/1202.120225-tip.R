
N <- 10
for(i in 1:N){
  Sys.sleep(0.5)
  cat("\r", i, "of", N)
}

