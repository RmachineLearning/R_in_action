source("interval_estimate2.R")
x<-rnorm(100, 5.32, 2.18)
y<-rnorm(100, 5.76, 1.76)
interval_estimate2(x,y, sigma=c(2.18, 1.76))
