mouse<-data.frame(
   X=c( 2, 4, 3, 2, 4,  7, 7, 2, 2, 5, 4, 5,  6, 8, 5, 10, 7,
      12, 12, 6, 6, 7, 11, 6, 6, 7, 9, 5, 5, 10, 6, 3, 10),
   A=factor(c(rep(1,11),rep(2,10), rep(3,12)))
)
mouse.aov<-aov(X ~ A, data=mouse)
source("anova.tab.R"); anova.tab(mouse.aov)

