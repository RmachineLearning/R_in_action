#----------------------------------------------------------------#
# R in Action: Chapter 6                                         #
# requires that the vcd, plotrix, sm, vioplot packages have been #
# installed                                                      #
# install.packages(c('vcd', 'plotrix', 'sm', 'vioplot'))         #
#----------------------------------------------------------------#

# pause after each graph
par(ask = TRUE)

# save original graphic settings
opar <- par(no.readonly = TRUE)

# Load vcd package
library(vcd)

# Get cell counts for improved variable
counts <- table(Arthritis$Improved)
counts

# Listing 6.1 - Simple bar plot

# simple bar plot
barplot(counts, main = "Simple Bar Plot", xlab = "Improvement", 
    ylab = "Frequency")

# horizontal bar plot
barplot(counts, main = "Horizontal Bar Plot", xlab = "Frequency", 
    ylab = "Improvement", horiz = TRUE)


# get counts for Improved by Treatment table
counts <- table(Arthritis$Improved, Arthritis$Treatment)
counts

# Listing 6.2 - Stacked and groupde bar plots

# stacked barplot
barplot(counts, main = "Stacked Bar Plot", xlab = "Treatment", 
    ylab = "Frequency", col = c("red", "yellow", "green"), 
    legend = rownames(counts))

# grouped barplot
barplot(counts, main = "Grouped Bar Plot", xlab = "Treatment", 
    ylab = "Frequency", col = c("red", "yellow", "green"), 
    legend = rownames(counts), 
    beside = TRUE)


# Listing 6.3 - Mean bar plots

states <- data.frame(state.region, state.x77)
means <- aggregate(states$Illiteracy, 
    by = list(state.region), 
    FUN = mean)
means

means <- means[order(means$x), ]
means

barplot(means$x, names.arg = means$Group.1)
title("Mean Illiteracy Rate")

# Listing 6.4 - Fitting labels in bar plots

par(mar = c(5, 8, 4, 2))
par(las = 2)
counts <- table(Arthritis$Improved)

barplot(counts, main = "Treatment Outcome", horiz = TRUE, 
    cex.names = 0.8, names.arg = c("No Improvement", 
    "Some Improvement", "Marked Improvement"))

# Section --6.1.5 Spinograms--

library(vcd)
attach(Arthritis)
counts <- table(Treatment, Improved)
spine(counts, main = "Spinogram Example")
detach(Arthritis)


# Listing 6.5 - Pie charts

par(mfrow = c(2, 2))
slices <- c(10, 12, 4, 16, 8)
lbls <- c("US", "UK", "Australia", "Germany", "France")

pie(slices, labels = lbls, main = "Simple Pie Chart")

pct <- round(slices/sum(slices) * 100)
lbls2 <- paste(lbls, " ", pct, "%", sep = "")
pie(slices, labels = lbls2, col = rainbow(length(lbls)), 
    main = "Pie Chart with Percentages")

library(plotrix)
pie3D(slices, labels = lbls, explode = 0.1, main = "3D Pie Chart ")

mytable <- table(state.region)
lbls <- paste(names(mytable), "\n", mytable, sep = "")
pie(mytable, labels = lbls, 
    main = "Pie Chart from a Table\n (with sample sizes)")

# restore original graphic parameters
par(opar)

# fan plots
library(plotrix)
slices <- c(10, 12, 4, 16, 8)
lbls <- c("US", "UK", "Australia", "Germany", "France")
fan.plot(slices, labels = lbls, main = "Fan Plot")


# Listing 6.6 - Histograms

par(mfrow = c(2, 2))

hist(mtcars$mpg)

hist(mtcars$mpg, breaks = 12, col = "red", 
    xlab = "Miles Per Gallon", 
    main = "Colored histogram with 12 bins")

hist(mtcars$mpg, freq = FALSE, breaks = 12, col = "red", 
    xlab = "Miles Per Gallon", 
    main = "Histogram, rug plot, density curve")
rug(jitter(mtcars$mpg))
lines(density(mtcars$mpg), col = "blue", lwd = 2)

# Histogram with Superimposed Normal Curve 
# (Thanks to Peter Dalgaard)
x <- mtcars$mpg
h <- hist(x, breaks = 12, col = "red", 
    xlab = "Miles Per Gallon", 
    main = "Histogram with normal curve and box")
xfit <- seq(min(x), max(x), length = 40)
yfit <- dnorm(xfit, mean = mean(x), sd = sd(x))
yfit <- yfit * diff(h$mids[1:2]) * length(x)
lines(xfit, yfit, col = "blue", lwd = 2)
box()

# restore original graphic parameters
par(opar)

# Listing 6.7 - Kernel density plot

par(mfrow = c(2, 1))
d <- density(mtcars$mpg)

plot(d)

d <- density(mtcars$mpg)
plot(d, main = "Kernel Density of Miles Per Gallon")
polygon(d, col = "red", border = "blue")
rug(mtcars$mpg, col = "brown")

# restore original graphic parameters
par(opar)

# Listing 6.8 - Comparing kernel density plots

par(lwd = 2)
library(sm)
attach(mtcars)

cyl.f <- factor(cyl, levels = c(4, 6, 8), 
    labels = c("4 cylinder", "6 cylinder", "8 cylinder"))

sm.density.compare(mpg, cyl, xlab = "Miles Per Gallon")
title(main = "MPG Distribution by Car Cylinders")

colfill <- c(2:(2 + length(levels(cyl.f))))
cat("Use mouse to place legend...", "\n\n")
legend(locator(1), levels(cyl.f), fill = colfill)
detach(mtcars)
par(lwd = 1)

# --Section 6.5--

boxplot(mpg ~ cyl, data = mtcars, 
    main = "Car Milage Data", 
    xlab = "Number of Cylinders", 
    ylab = "Miles Per Gallon")

boxplot(mpg ~ cyl, data = mtcars, notch = TRUE, 
    varwidth = TRUE, col = "red", 
    main = "Car Mileage Data", 
    xlab = "Number of Cylinders", 
    ylab = "Miles Per Gallon")

# Listing 6.9 - Box plots for two crossed factors

mtcars$cyl.f <- factor(mtcars$cyl, levels = c(4, 6, 
    8), labels = c("4", "6", "8"))

mtcars$am.f <- factor(mtcars$am, levels = c(0, 1), 
    labels = c("auto", "standard"))

boxplot(mpg ~ am.f * cyl.f, data = mtcars, 
    varwidth = TRUE, col = c("gold", "darkgreen"), 
    main = "MPG Distribution by Auto Type", 
    xlab = "Auto Type")

# Listing 6.10 - Violin plots

library(vioplot)
x1 <- mtcars$mpg[mtcars$cyl == 4]
x2 <- mtcars$mpg[mtcars$cyl == 6]
x3 <- mtcars$mpg[mtcars$cyl == 8]
vioplot(x1, x2, x3, 
    names = c("4 cyl", "6 cyl", "8 cyl"), 
    col = "gold")
title("Violin Plots of Miles Per Gallon")

# --Section 6.6--

dotchart(mtcars$mpg, labels = row.names(mtcars), 
    cex = 0.7, 
    main = "Gas Milage for Car Models", 
    xlab = "Miles Per Gallon")

# Listing 6.11 - sorted colored grouped dot chart

x <- mtcars[order(mtcars$mpg), ]
x$cyl <- factor(x$cyl)
x$color[x$cyl == 4] <- "red"
x$color[x$cyl == 6] <- "blue"
x$color[x$cyl == 8] <- "darkgreen"
dotchart(x$mpg, labels = row.names(x), cex = 0.7, 
    pch = 19, groups = x$cyl, 
    gcolor = "black", color = x$color, 
    main = "Gas Milage for Car Models\ngrouped by cylinder", 
    xlab = "Miles Per Gallon")
    