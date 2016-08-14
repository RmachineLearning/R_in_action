x <- 1:20
w <- 1 + sqrt(x)/2
dummy <- data.frame(x=x, y= x + rnorm(x)*w)
fm <- lm(y ~ x, data=dummy)
summary(fm)