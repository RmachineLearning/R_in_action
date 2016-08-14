
par("mar")
par("mgp")
par("las")

set.seed(5)
x <- rnorm(200)
y <- 25 - 22*x + 5*x^2 + rnorm(200)

png("par-120208-01.png")
plot(x, y, main="defaults")
dev.off()

png("par-120208-02.png")
par(mar=c(3.5, 3.5, 2, 1))
plot(x, y, main="par(mar=c(3.5, 3.5, 2, 1))")
dev.off()

png("par-120208-03.png")
par(mar=c(3.5, 3.5, 2, 1), mgp=c(2.4, 0.8, 0))
plot(x, y, main="par(mar=c(3.5, 3.5, 2, 1), mgp=c(2.4, 0.8, 0))")
dev.off()

png("par-120208-04.png")
par(mar=c(3.5, 3.5, 2, 1), mgp=c(2.4, 0.8, 0), las=1)
plot(x, y, main="par(mar=c(3.5, 3.5, 2, 1), mgp=c(2.4, 0.8, 0), las=1)")
dev.off()



pdf("par-120208.pdf")
plot(x, y, main="defaults")
par(mar=c(3.5, 3.5, 2, 1))
plot(x, y, main="par(mar=c(3.5, 3.5, 2, 1))")
par(mar=c(3.5, 3.5, 2, 1), mgp=c(2.4, 0.8, 0))
plot(x, y, main="par(mar=c(3.5, 3.5, 2, 1), mgp=c(2.4, 0.8, 0))")
par(mar=c(3.5, 3.5, 2, 1), mgp=c(2.4, 0.8, 0), las=1)
plot(x, y, main="par(mar=c(3.5, 3.5, 2, 1), mgp=c(2.4, 0.8, 0), las=1)")
dev.off()

