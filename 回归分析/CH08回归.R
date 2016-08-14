#------------------------------------------------------------------------#
# R in Action: Chapter 8                                                 #
# requires that the car, gvlma, MASS, leaps packages have been installed #
# install.packages(c('car', 'gvlma', 'MASS', 'leaps'))                   #
#------------------------------------------------------------------------#

# pause on each graph
par(ask = TRUE)

# save current graphical parameters
opar <- par(no.readonly = TRUE)

# Listing 8.1 - simple linear regression

fit <- lm(weight ~ height, data = women)
summary(fit)
women$weight
fitted(fit)
residuals(fit)

# scatter plot of height by weight

plot(women$height, women$weight, main = "Women Age 30-39", 
    xlab = "Height (in inches)", ylab = "Weight (in pounds)")
# add the line of best fit
abline(fit)

# Listing 8.2 - Polynomial regression

fit2 <- lm(weight ~ height + I(height^2), data = women)
summary(fit2)

plot(women$height, women$weight, main = "Women Age 30-39", 
    xlab = "Height (in inches)", ylab = "Weight (in lbs)")
lines(women$height, fitted(fit2))

# scatterplot for women data

library(car)
scatterplot(weight ~ height, data = women, spread = FALSE, 
    lty.smooth = 2, pch = 19, main = "Women Age 30-39", xlab = "Height (inches)", 
    ylab = "Weight (lbs.)")

# Listing 8.3 - Examining bivariate relationship

states <- as.data.frame(state.x77[, c("Murder", "Population", 
    "Illiteracy", "Income", "Frost")])
    
cor(states)

library(car)
scatterplotMatrix(states, spread = FALSE, lty.smooth = 2, 
    main = "Scatterplot Matrix")
    
# Listing 8.4 - Multiple linear regression

fit <- lm(Murder ~ Population + Illiteracy + Income + 
    Frost, data = states)
    
# Listing 8.5 Multiple linear regression with a significant
# interaction term

fit <- lm(mpg ~ hp + wt + hp:wt, data = mtcars)
summary(fit)

library(effects)
plot(effect("hp:wt", fit, list(wt = c(2.2, 3.2, 4.2))), 
    multiline = TRUE)
    
# --Section 8.3--

fit <- lm(Murder ~ Population + Illiteracy + Income +
    Frost, data=states)
confint(fit)

# simple regression diagnostics

fit <- lm(weight ~ height, data = women)
par(mfrow = c(2, 2))
plot(fit)
par(opar)

# regression diagnostics for quadratic fit

newfit <- lm(weight ~ height + I(height^2), data = women)
par(mfrow = c(2, 2))
plot(newfit)
par(opar)

# regression diagnostics for quadratic fit 
# with deleted observations

newfit <- lm(weight ~ height + I(height^2), data = women[-c(13, 15),])
par(mfrow = c(2, 2))
plot(newfit)
par(opar)

# basic regression diagnostics for states data

fit <- lm(Murder ~ Population + Illiteracy + Income + 
    Frost, data = states)
par(mfrow = c(2, 2))
plot(fit)
par(opar)

# Assessing normality
library(car)
fit <- lm(Murder ~ Population + Illiteracy + Income + 
    Frost, data = states)
qqPlot(fit, labels = FALSE, simulate = TRUE, main = "Q-Q Plot")


# Listing 8.6 Function for plotting studentized residuals

residplot <- function(fit, nbreaks=10) {
    z <- rstudent(fit)
    hist(z, breaks=nbreaks, freq=FALSE,
    xlab="Studentized Residual",
    main="Distribution of Errors")
    rug(jitter(z), col="brown")
    curve(dnorm(x, mean=mean(z), sd=sd(z)),
        add=TRUE, col="blue", lwd=2)
    lines(density(z)$x, density(z)$y,
        col="red", lwd=2, lty=2)
    legend("topright",
        legend = c( "Normal Curve", "Kernel Density Curve"),
        lty=1:2, col=c("blue","red"), cex=.7)
}

residplot(fit)

#  Durbin Watson test for Autocorrelated Errors

durbinWatsonTest(fit)

# Component + Residual Plots

crPlots(fit, one.page = TRUE, ask = FALSE)

# Listing 8.7 - Assessing homoscedasticity

library(car)
ncvTest(fit)
spreadLevelPlot(fit)

# Listing 8.8 - Global test of linear model assumptions

library(gvlma)
gvmodel <- gvlma(fit)
summary(gvmodel)

# Library 8.9 - Evaluating multi-collinearity

vif(fit)
sqrt(vif(fit)) > 2

# --Section 8.4--

# Assessing outliers

library(car)
outlierTest(fit)

# Index plot of hat values
# use the mouse to identify points interactively

hat.plot <- function(fit){
    p <- length(coefficients(fit))
    n <- length(fitted(fit))
    plot(hatvalues(fit), main = "Index Plot of Hat Values")
    abline(h = c(2, 3) * p/n, col = "red", lty = 2)
    identify(1:n, hatvalues(fit), names(hatvalues(fit)))
}

hat.plot(fit)

# Cook's D Plot
# identify D values > 4/(n-k-1)

cutoff <- 4/(nrow(states) - length(fit$coefficients) - 2)
plot(fit, which = 4, cook.levels = cutoff)
abline(h = cutoff, lty = 2, col = "red")

# Added variable plots
# use the mouse to identify points interactively

avPlots(fit, ask = FALSE, onepage = TRUE, id.method = "identify")

# Influence Plot
# use the mouse to identify points interactively

influencePlot(fit, id.method = "identify", main = "Influence Plot", 
    sub = "Circle size is proportial to Cook's Distance")

# Listing 8.10 - Box-Cox Transformation to normality

library(car)
summary(powerTransform(states$Murder))

# Box-Tidwell Transformations to Linearity

library(car)
boxTidwell(Murder ~ Population + Illiteracy, data = states)

# Listing 8.11 - Comparing nested models using the anova function

fit1 <- lm(Murder ~ Population + Illiteracy + Income + 
    Frost, data = states)
fit2 <- lm(Murder ~ Population + Illiteracy, data = states)
anova(fit2, fit1)

# Listing 8.12 - Comparing models with the Akaike Information Criterion

fit1 <- lm(Murder ~ Population + Illiteracy + Income + 
    Frost, data = states)
fit2 <- lm(Murder ~ Population + Illiteracy, data = states)
AIC(fit1, fit2)

# Listing 8.13 - Backward stepwise selection

library(MASS)
fit1 <- lm(Murder ~ Population + Illiteracy + Income + 
    Frost, data = states)
stepAIC(fit, direction = "backward")

# Listing 8.14 - All subsets regression
# use the mouse to place the legend interactively 
# in the second plot

library(leaps)
leaps <- regsubsets(Murder ~ Population + Illiteracy + 
    Income + Frost, data = states, nbest = 4)
plot(leaps, scale = "adjr2")

library(car)
subsets(leaps, statistic = "cp", 
    main = "Cp Plot for All Subsets Regression")
abline(1, 1, lty = 2, col = "red")

# Listing 8.15 - Function for k-fold cross-validated R-square
shrinkage <- function(fit, k = 10) {
    require(bootstrap)
    # define functions
    theta.fit <- function(x, y) {
        lsfit(x, y)
    }
    theta.predict <- function(fit, x) {
        cbind(1, x) %*% fit$coef
    }
    
    # matrix of predictors
    x <- fit$model[, 2:ncol(fit$model)]
    # vector of predicted values
    y <- fit$model[, 1]
    
    results <- crossval(x, y, theta.fit, theta.predict, ngroup = k)
    r2 <- cor(y, fit$fitted.values)^2
    r2cv <- cor(y, results$cv.fit)^2
    cat("Original R-square =", r2, "\n")
    cat(k, "Fold Cross-Validated R-square =", r2cv, "\n")
    cat("Change =", r2 - r2cv, "\n")
}

# using shrinkage()

fit <- lm(Murder ~ Population + Income + Illiteracy + 
    Frost, data = states)
shrinkage(fit)

fit2 <- lm(Murder ~ Population + Illiteracy, data = states)
shrinkage(fit2)

#  Calculating standardized regression coefficients
zstates <- as.data.frame(scale(states))
zfit <- lm(Murder ~ Population + Income + Illiteracy + 
    Frost, data = zstates)
coef(zfit)

# Listing 8.16 - relweights() function for calculating relative
# importance of predictors

########################################################################
# The relweights function determines the relative importance of each   #
# independent variable to the dependent variable in an OLS regression. #
# The code is adapted from an SPSS program generously provided by      #
# Dr. Johnson.                                                         #
#                                                                      #
# See Johnson (2000, Multivariate Behavioral Research, 35, 1-19) for   #
# an explanation of how the relative weights are derived.              #
########################################################################
relweights <- function(fit, ...) {
    R <- cor(fit$model)
    nvar <- ncol(R)
    rxx <- R[2:nvar, 2:nvar]
    rxy <- R[2:nvar, 1]
    svd <- eigen(rxx)
    evec <- svd$vectors
    ev <- svd$values
    delta <- diag(sqrt(ev))
    
    # correlations between original predictors and new orthogonal variables
    lambda <- evec %*% delta %*% t(evec)
    lambdasq <- lambda^2
    
    # regression coefficients of Y on orthogonal variables
    beta <- solve(lambda) %*% rxy
    rsquare <- colSums(beta^2)
    rawwgt <- lambdasq %*% beta^2
    import <- (rawwgt/rsquare) * 100
    lbls <- names(fit$model[2:nvar])
    rownames(import) <- lbls
    colnames(import) <- "Weights"
    
    # plot results
    barplot(t(import), names.arg = lbls, ylab = "% of R-Square", 
        xlab = "Predictor Variables", main = "Relative Importance of Predictor Variables", 
        sub = paste("R-Square = ", round(rsquare, digits = 3)), 
        ...)
    return(import)
}

# using relweights()

fit <- lm(Murder ~ Population + Illiteracy + Income + 
    Frost, data = states)
relweights(fit, col = "lightgrey")