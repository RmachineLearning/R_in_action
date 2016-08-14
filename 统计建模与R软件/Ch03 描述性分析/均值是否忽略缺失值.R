w<-c(75.0, 64.0, 47.4, 66.9, 62.2, 62.2, 58.7, 63.5, 
      66.6, 64.0, 57.0, 69.0, 56.9, 50.0, 72.0)
w.mean<-mean(w); w.mean 

w[1]<-750
w.mean<-mean(w,trim=0.1); w.mean 

w[16]<-NA
w.mean<-mean(w,na.rm=TRUE); w.mean 

