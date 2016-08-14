
set.seed(5)
N    <- 50
x    <- rnorm(N)
temp <- .Last.value
identical(x, temp)

lp <- -2 + 3*x
p  <- exp(lp) / (1 + exp(lp))
y  <- ifelse(runif(N) < p, 1, 0)

X  <- seq(-5, 5, 0.01)
LP <- -2 + 3*X
P  <- exp(LP) / (1 + exp(LP))

png("LastValue.png")
plot(X, P, xlim=range(x), ylim=0:1,
     type="l", ylab="Probability")
points(x, y, col=2)
dev.off()

glm(y ~ x, binomial)
model <- .Last.value
model

summary(model)
