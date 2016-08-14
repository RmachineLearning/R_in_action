
set.seed(5)

x <- rnorm(1000)
range(x)
any(x > 3)
any(is.na(x))
all(x > -3)
all(x > -3.5)


x <- sample(c(TRUE, FALSE), 3, TRUE)
x
any(x)
all(x)

x <- rep(FALSE, 3)
x
any(x)
all(x)

x <- rep(TRUE, 3)
x
any(x)
all(x)

x <- c()
x
any(x)
all(x)
