rt<-read.table("../chapter03/applicant.data")
c<-cor(rt)
index<-as.dist(1-c)
hc1<-hclust(index, "complete")
hc2<-hclust(index, "average")
hc3<-hclust(index, "centroid")
hc4<-hclust(index, "ward")

opar<-par(mfrow=c(2,1), mar=c(5.2,4,0,0))
plclust(hc1,hang=-1)
re1<-rect.hclust(hc1,k=5,border="red")
plclust(hc2,hang=-1)
re2<-rect.hclust(hc2,k=5,border="red")
par(opar)

opar<-par(mfrow=c(2,1), mar=c(5.2,4,0,0))
plclust(hc3,hang=-1)
re3<-rect.hclust(hc3,k=5,border="red")
plclust(hc4,hang=-1)
re4<-rect.hclust(hc4,k=5,border="red")
par(opar)


