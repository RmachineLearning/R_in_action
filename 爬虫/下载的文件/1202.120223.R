
# If using Windows, may need to use Cairo
# package to utilize transparency
# 
# library(Cairo)

set.seed(5)
x  <- runif(100)
y  <- 4*x + rnorm(100)
z  <- 2*x + 0.3*y + rnorm(100, sd=0.5)
c1 <- (z - min(z)) / (max(z) - min(z))
c2 <- (z - min(z) + 2) / (max(z) - min(z) + 2)

col1 <- rgb(1-c1, 0.5*c1, c1)
col1[1:5]

col2 <- rgb(0, 0, 0, c2)
col2[1:5]

col3 <- rgb(1-c1, 0.5*c1, c1, 0.7)
col3[1:5]

# CairoPNG("rgb1.png")
png("rgb1.png")
plot(x, y, col=col1, pch=19, cex=4)
dev.off()

# CairoPNG("rgb2.png")
png("rgb2.png")
plot(x, y, col=col2, pch=19, cex=4)
dev.off()

# CairoPNG("rgb3.png")
png("rgb3.png")
plot(x, y, col=col3, pch=19, cex=4)
dev.off()
