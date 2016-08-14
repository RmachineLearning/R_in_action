x<-c(60, 3, 32, 11)
dim(x)<-c(2, 2)
chisq.test(x, correct = FALSE)

chisq.test(x)