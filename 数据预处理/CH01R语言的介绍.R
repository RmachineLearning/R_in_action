#------------------------------------------------------#
# R in Action: Chapter 1                               #
#------------------------------------------------------#

# In the following code q() is commented out so that
# you don't quit the session

# Listing 1.1 - A Sample R session

age <- c(1, 3, 5, 2, 11, 9, 3, 9, 12, 3)
weight <- c(4.4, 5.3, 7.2, 5.2, 8.5, 7.3, 6, 10.4, 
    10.2, 6.1)
mean(weight)
sd(weight)
cor(age, weight)
plot(age, weight)
# q()

# Listing 1.2 - An example of commands used to manage
# the R Workspace. Change the next line to one of your 
# directories

setwd("C:/myprojects/project1")
options()
options(digits=3)
x <- runif(20)
summary(x)
hist(x)
savehistory()
save.image()
# q()

# Listing 1.3 - Working with a new package

help.start()
install.packages("vcd")
help(package = "vcd")
library(vcd)
help(Arthritis)
Arthritis
example(Arthritis)
# q()
