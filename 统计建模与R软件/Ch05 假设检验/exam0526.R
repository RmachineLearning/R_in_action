x<-c(24, 26, 29, 34, 43, 58, 63, 72, 87, 101)
y<-c(82, 87, 97, 121, 164, 208, 213)
wilcox.test(x, y, alternative="less", exact=FALSE, correct=FALSE)
wilcox.test(x, y, alternative="less", exact=FALSE)

