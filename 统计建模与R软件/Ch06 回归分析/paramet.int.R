paramet.int<-function(fm,alpha=0.05){
   fm.sum<-summary(fm)
   paramet <- fm.sum$parameters[,1]
   df <- fm.sum$df[2]
   left <- paramet-fm.sum$parameters[,2]
   right <- paramet+fm.sum$parameters[,2]
   rowname <- dimnames(fm.sum$parameters)[[1]]
   colname <- c("Estimate", "Left", "Right")
   matrix(c(paramet,left, right), ncol=3,
          dimnames = list(rowname, colname ))
}
