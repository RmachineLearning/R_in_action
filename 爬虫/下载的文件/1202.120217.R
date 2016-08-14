
scatterBox <- function(x, y, ...){
  opar <- par("mfrow", "mar")
  on.exit(par(opar))
  
  mat <- matrix(c(1,2,0,3), 2)
  layout(mat, c(3.5,1), c(1,3))
  par(mar=c(0.5, 4.5, 0.5, 0.5))
  boxplot(x, horizontal=TRUE, axes=FALSE)
  par(mar=c(4.5, 4.5, 0.5, 0.5))
  plot(x, y, ...)
  par(mar=c(4.5, 0.5, 0.5, 0.5))
  boxplot(y, axes=FALSE)
}

set.seed(5)
x <- rnorm(200)
y <- 25 - 22*x + 5*x^2 + rnorm(200)

#png("onexit.png")
scatterBox(x, y)
#dev.off()

#png("onexitafter.png")
plot(x, y)
#dev.off()

