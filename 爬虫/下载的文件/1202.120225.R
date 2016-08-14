
set.seed(5)
N <- 12
x <- rpois(N, rpois(N, 1.5))
x

# Space separator
cat(x)

# Multi-space separator
cat(x, sep=" . ")

# Tab separator
cat(x, sep="\t")

# Line Break separator
cat(x, sep="\n")

y <- sample(c("home", "away"), N, TRUE)
y

cat(x, y)

cat(x[1], y[1], sep="\t")

#===> Practice Run For Writing File <===#
for(i in 1:3){
  cat(x[i], y[i], sep="\t")
  cat("\n")
}

#===> Could Append To Existing File <===#
for(i in 1:N){
  cat(x[i], y[i], file="data1.txt", sep="\t", append=TRUE)
  cat("\n", file="data1.txt", append=TRUE)
}


