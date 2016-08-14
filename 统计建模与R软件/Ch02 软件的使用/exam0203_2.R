df<-data.frame(
  Name=c("Alice", "Becka", "Gail", "Karen", "Kathy", 
         "Mary", "Sandy", "Sharon", "Tammy", "Alfred", 
         "Duke", "Guido", "James", "Jeffrey", "John", 
         "Philip", "Robert", "Thomas", "William"), 
  Sex=c("F", "F", "F", "F", "F", "F", "F", "F", "F", 
        "M", "M", "M", "M", "M", "M", "M", "M", "M", "M"), 
  Age=c(13, 13, 14, 12, 12, 15, 11, 15, 14, 14, 14, 15,
        12, 13, 12, 16, 12, 11, 15 ), 
  Height=c(56.5, 65.3, 64.3, 56.3, 59.8, 66.5, 51.3, 
           62.5, 62.8, 69.0, 63.5, 67.0, 57.3, 62.5, 
           59.0, 72.0, 64.8, 57.5, 66.5), 
  Weight=c( 84.0,  98.0,  90.0,  77.0,  84.5, 112.0, 
            50.5, 112.5, 102.5, 112.5, 102.5, 133.0,
            83.0,  84.0,  99.5, 150.0, 128.0,  85.0, 
           112.0)
); df


df<-data.frame(
  Name=c("Alice", "Becka", "James", "Jeffrey", "John"), 
  Sex=c("F", "F", "M", "M", "M"), 
  Age=c(13, 13, 12, 13, 12),
  Height=c(56.5, 65.3, 57.3, 62.5, 59.0), 
  Weight=c(84.0, 98.0, 83.0, 84.0, 99.5)
); df

Lst<-list(
  Name=c("Alice", "Becka", "James", "Jeffrey", "John"), 
  Sex=c("F", "F", "M", "M", "M"), 
  Age=c(13, 13, 12, 13, 12),
  Height=c(56.5, 65.3, 57.3, 62.5, 59.0), 
  Weight=c(84.0, 98.0, 83.0, 84.0, 99.5)
); Lst

rt<-read.table("exam0203.txt", head=TRUE); rt
lm.sol<-lm(Weight~Height, data=rt)
summary(lm.sol)

attach(rt)
plot(Height, Weight)

attach(lm.sol)
xpre<-c(min(Height), max(Height)); xpre
ypre<-coefficients[1]+coefficients[2]*xpre;
lines(xpre, ypre)
