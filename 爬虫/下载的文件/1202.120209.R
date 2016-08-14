
x  <- list()
xs <- rep(NA, 7)
for(i in 1:7){
	X      <- rnorm(10^i)
	xs[i]  <- object.size(X)
	x[[i]] <- X
}


xs
png("objectsize.png")
plot(10^(1:7), xs, log="xy",
     xlab="Vector Length", ylab="Memory")
dev.off()


object.size(x)
object.size(x) - sum(xs)
