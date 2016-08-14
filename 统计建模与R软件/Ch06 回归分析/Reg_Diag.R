Reg_Diag<-function(fm){
   n<-nrow(fm$model); df<-fm$df.residual
   p<-n-df-1; s<-rep(" ", n);  
   res<-residuals(fm); s1<-s; s1[abs(res)==max(abs(res))]<-"*"
   sta<-rstandard(fm); s2<-s; s2[abs(sta)>2]<-"*"
   stu<-rstudent(fm); s3<-s; s3[abs(sta)>2]<-"*"
   h<-hatvalues(fm); s4<-s; s4[h>2*(p+1)/n]<-"*"
   d<-dffits(fm); s5<-s; s5[abs(d)>2*sqrt((p+1)/n)]<-"*"
   c<-cooks.distance(fm); s6<-s; s6[c==max(c)]<-"*"
   co<-covratio(fm);   abs_co<-abs(co-1)
   s7<-s; s7[abs_co==max(abs_co)]<-"*"
   data.frame(residual=res, s1, standard=sta, s2, 
              student=stu, s3,  hat_matrix=h, s4, 
              DFFITS=d, s5,cooks_distance=c, s6, 
              COVRATIO=co, s7)
}
   