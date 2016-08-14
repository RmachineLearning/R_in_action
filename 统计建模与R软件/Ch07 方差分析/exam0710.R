agriculture<-data.frame(
   Y=c(325, 292, 316, 317, 310, 318, 
       310, 320, 318, 330, 370, 365),
   A=gl(4,3),
   B=gl(3,1,12)
)
agriculture.aov <- aov(Y ~ A+B, data=agriculture)
source("anova.tab.R"); anova.tab(agriculture.aov)