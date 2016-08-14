
# install.packages("xtable")

library(xtable)
methods(xtable)

mat <- matrix(rnorm(8), 4)
xtable(mat)

set.seed(5)
x <- 1:10
y <- x + rnorm(10)
g <- lm(y ~ x)
xtable(g)
