X<-c(159, 280, 101, 212, 224, 379, 179, 264,
     222, 362, 168, 250, 149, 260, 485, 170)
source("mean.test1.R")
mean.test1(X, mu=225, side=1)

source("../chapter04/interval_estimate4.R")
interval_estimate4(X, side=1)
