points<-scan()
93 75 83 93 91 85 84 82 77 76 77 95 94 89 91
88 86 83 96 81 79 97 78 75 67 69 68 83 84 81
75 66 85 70 94 84 83 82 80 78 74 73 76 70 86
76 90 89 71 66 86 73 80 94 79 78 77 63 53 55

X<-hist(points, br=c(0, 69, 79,89,100), plot=FALSE)$counts; X
mu<-mean(points); s<-sd(points)

b<-c(70,80,90)
p<-pnorm(b, mu, s)
p<-c(p[1], p[2]-p[1], p[3]-p[2], 1-p[3]);p

chisq.test(X,p=p)
chisq.test(X,p=p,simulate.p.value = TRUE, B = 2000)