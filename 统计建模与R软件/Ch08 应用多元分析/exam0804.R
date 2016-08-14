X<-iris[,1:4]
G<-gl(3,50)
source("distinguish.bayes.R")
distinguish.bayes(X,G)