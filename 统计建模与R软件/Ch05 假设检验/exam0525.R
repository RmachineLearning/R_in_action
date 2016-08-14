x<-c(459, 367, 303, 392, 310, 342, 421, 446, 430, 412)
y<-c(414, 306, 321, 443, 281, 301, 353, 391, 405, 390)
wilcox.test(x, y, alternative = "greater", paired = TRUE)

binom.test(sum(x>y), length(x), alternative = "greater")



