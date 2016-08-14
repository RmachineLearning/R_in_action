ore<-data.frame(
     x=c(67, 54, 72, 64, 39, 22, 58, 43, 46, 34),
     y=c(24, 15, 23, 19, 16, 11, 20, 16.1, 17, 13)
)
ore.m<-mean(ore); ore.m
ore.s<-cov(ore); ore.s
ore.r<-cor(ore); ore.r

attach(ore)
cor.test(x,y)

cor.test(x,y, method="spearman")

cor.test(x,y, method="kendall")

