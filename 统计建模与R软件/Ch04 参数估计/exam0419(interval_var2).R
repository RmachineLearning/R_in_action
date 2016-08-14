A<-scan()
79.98 80.04 80.02 80.04 80.03 80.03 80.04 79.97
80.05 80.03 80.02 80.00 80.02

B<-scan()
80.02 79.94 79.98 79.97 79.97 80.03 79.95 79.97

source("interval_var2.R")
interval_var2(A,B, mu=c(80,80))

interval_var2(A,B)

var.test(A,B)