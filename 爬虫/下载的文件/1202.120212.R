
month    <- month.abb
avgHigh  <- c(38, 41, 47, 56, 69, 81, 83, 82, 71, 55, 48, 43)
seasons  <- c("Winter", "Spring", "Summer", "Fall")
season   <- rep(seasons[c(1:4,1)], c(2,3,3,3,1))
schoolIn <- rep(c("yes", "no", "yes"), c(5, 3, 4))

getwd()
d        <- data.frame(month, avgHigh, season, schoolIn)
write.table(d, "annual.txt", quote=FALSE,
            sep="\t", row.names=FALSE)

rm(list=ls())
ls()
d <- read.delim("annual.txt", header=TRUE, sep="\t")
d
