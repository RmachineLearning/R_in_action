source("interval_estimate2.R")
x<-rnorm(12, 501.1, 2.4)
y<-rnorm(17, 499.7, 4.7)
interval_estimate2(x,y, var.equal=TRUE)
interval_estimate2(x,y)

t.test(x,y, var.equal=TRUE)
t.test(x,y)

