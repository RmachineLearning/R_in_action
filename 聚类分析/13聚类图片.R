
#图片聚类分类

install.packages("png")
library(png)

img2 = readPNG("./ml_R_cookbook-master/CH9/handwriting.png", TRUE)
img3 = img2[,nrow(img2):1]
b = cbind(as.integer(which(img3 < -1) %% 28), which(img3 < -1) /28)
plot(b, xlim=c(1,28), ylim=c(1,28))

fit = kmeans(b, 2)
plot(b, col=fit$cluster)
plot(b, col=fit$cluster,xlim=c(1,28), ylim=c(1,28))
