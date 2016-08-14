anova.tab<-function(fm){
   tab<-summary(fm)
   k<-length(tab[[1]])-2
   temp<-c(sum(tab[[1]][,1]), sum(tab[[1]][,2]), rep(NA,k))
   tab[[1]]["Total",]<-temp
   tab
}
