food<-data.frame(
   x=c(164, 190, 203, 205, 206, 214, 228, 257,
       185, 197, 201, 231,
       187, 212, 215, 220, 248, 265, 281,
       202, 204, 207, 227, 230, 276),
   g=factor(rep(1:4, c(8,4,7,6)))
)
kruskal.test(x~g, data=food)

shapiro.test(food$x[food$g==1])
shapiro.test(food$x[food$g==2])
shapiro.test(food$x[food$g==3])
shapiro.test(food$x[food$g==4])

bartlett.test(x~g, data=food)

source("anova.tab.R")
anova.tab(aov(x~g, data=food))