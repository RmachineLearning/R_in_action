rt<-read.table("../chapter03/applicant.data")
fa<-factanal(~., factors=5, data=rt, scores="Bartlett")
fa<-factanal(~., factors=5, data=rt, scores="regression")

plot(fa$scores[, 1:2], type="n"); text(fa$scores[,1], fa$scores[,2])
plot(fa$scores[, c(1,3)], type="n"); text(fa$scores[,1], fa$scores[,3])
